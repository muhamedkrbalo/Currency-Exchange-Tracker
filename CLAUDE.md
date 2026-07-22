# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Orientation

Read these before making non-trivial changes:


- **`.claude/agents/*.md`** — role-scoped agents with **disjoint file ownership**. Two agents never edit the same file; `core/di/injection.dart` is the one shared file, extended only via additive `_register<X>()` functions.

## Commands

```bash
flutter pub get                                          # install deps
dart run build_runner build --delete-conflicting-outputs # regenerate freezed / json / Hive code
flutter run                                              # run the app (no config/secrets needed)

flutter test                                             # full suite
flutter test test/features/rates/data/rate_mapper_test.dart   # a single file
flutter test --plain-name "inverts egp rate"             # a single test by name
flutter test --coverage

dart format --set-exit-if-changed .                      # formatting gate
flutter analyze                                          # static analysis
dart run import_lint                                     # dependency-boundary rules (exits non-zero on violation)
```

**Codegen:** `*.freezed.dart` / `*.g.dart` are committed, so `build_runner` is only needed after changing a freezed model/state/union, a `json_serializable` DTO, or a Hive adapter. `freezed` is pinned to a `3.2.x` prerelease on purpose — it is the only line whose `source_gen 4.x` satisfies `hive_ce_generator`. Don't "fix" it back to stable.

## Architecture essentials

Five layers, dependencies pointing **inward only** — `presentation → domain ← data`, with `core`/`shared` as leaves depended on by all, depending on nothing above. `dart run import_lint` (config in `analysis_options.yaml`) enforces this as a hard error, so:

- **Domain is pure Dart.** No Flutter, Dio, Hive, JSON, or `fromJson` in `features/*/domain/`.
- **Presentation never touches data directly** — it goes through domain (use cases / repository interfaces).
- **No feature→feature imports.** A shared entity (e.g. `CurrencyRate`, `HistoricalRate`) lives in its owning feature (`rates`) and is imported by `currency_detail`; cross-cutting code goes to `core`/`shared`.
- `core/di/injection.dart` is the deliberate exception that wires features together and is excluded from the `core_no_features` rule.

**The error boundary.** Two hierarchies, one translation point:
- Below the repository, code **throws** typed `AppException`s (mapped from `DioException` in `error_interceptor.dart`).
- At/above the repository, everything is a sealed `Result<T>` (`Success` | `FailureResult`) carrying a `Failure`. The repository is the *only* place exceptions become `Result` — wrap data calls in `guardAsync()` (in `result.dart`), which maps `AppException → Failure`. Exceptions must never escape the data layer.
- Cubits pattern-match the `Result` with an exhaustive `switch`; the UI turns a `Failure` into a message via `mapFailureToMessage`. Raw server messages are never shown except `ValidationFailure` (422).

**Networking.** The API host changes with the date, so there is **no fixed `baseUrl`** — `ApiConfig.latest()` / `onDate()` build full absolute `Uri`s and the client issues `getUri`. `DioFactory` (builds a `Dio`) and `DioApiClient` (implements `ApiClient` using an injected `Dio`) are two separate classes. Interceptor add-order is deliberate: `Retry → Logging → Error`. Repository calls accept a `CancelToken`; cubits cancel in `close()`.

**Data flow specifics.**
- The EGP inversion (`1 / egp.usd → EGP per unit`), the code→name join, and the today/yesterday pairing live **only** in `rate_mapper.dart`. Widgets never do rate math — `absoluteChange`/`percentChange`/`isEgpStrengthening` are computed getters on the `CurrencyRate` entity.
- `CurrencyRepositoryImpl` is the SSOT for cache policy: **cache-aside** — remote success caches to Hive and returns fresh; offline/timeout returns cached data. This is surfaced through state, not a side flag: `Loaded(rates, isFromCache, lastUpdated)` drives the offline banner and timestamp. `ConnectivityCubit` calls `RatesListCubit.refresh()` on reconnect.

**State management.** One Cubit per screen, immutable `freezed` state unions following `Initial | Loading | Loaded | Error(failure)`. Business logic stays in the cubit/domain — widgets only render state and fire commands.

**DI.** Manual `get_it`, no codegen. `configureDependencies()` calls one `_register<Feature>()` per area. Cubits/Blocs are `registerFactory` (fresh per screen — a singleton cubit leaks state); everything else is `registerLazySingleton`. Consumers depend on the abstraction (`ApiClient`, `CurrencyRepository`, `NetworkInfo`), bound to the concrete impl only in the composition root. Widgets get cubits via `BlocProvider(create: (_) => getIt<XCubit>())`. Tests call `getIt.reset()` in `tearDown`.

## Conventions

- **Commits:** Conventional Commits, scoped per PR (`feat(rates):`, `feat(di):`, `chore(lint):`, `ci:`, `docs:`). Branch namespaces map to agent ownership (see `.claude/agents/`). The user handles all `git commit`/`git push`.
- **Tests mirror `lib/` under `test/`** and every PR ships its own tests — never a "tests later" PR. Weight coverage toward the repository and cubit layers where resilience logic lives; test at layer boundaries against interfaces, using `mocktail` + `bloc_test`.
- **Theming/i18n:** no hardcoded colors or sizes — read theme tokens / `ThemeExtension`s (`context.appColors`); user-facing strings go through `easy_localization` `LocaleKeys` (en + ar, RTL).
