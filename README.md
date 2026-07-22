# Currency Exchange Tracker

A Flutter app that tracks live exchange rates for five major currencies against the
Egyptian Pound (**USD, EUR, GBP, SAR, JPY**), with a detail screen showing a 7‑day
historical chart and an offline cache that serves the last known rates when the device
is disconnected.

---

## Screenshots

| iOS | Android |
|:---:|:---:|
| <img src="screenshots/ios_rates_list.png" width="300" alt="Exchange rates list on iOS"/> | <img src="screenshots/android_rates_list.png" width="300" alt="Exchange rates list on Android"/> |

---

## Features

| Module | What it does |
|---|---|
| **1 — Rates list** | Live rate per currency (EGP per 1 unit), daily change (absolute + %), color‑coded green when the EGP strengthens / red when it weakens. Pull‑to‑refresh, plus loading / error / empty states. |
| **2 — Detail + chart** | Current rate, daily change, last‑updated date, and a 7‑day `fl_chart` line chart. The chart loads behind a **shimmer** (not a spinner) and degrades gracefully to a clear message on error/empty. |
| **3 — Offline cache** | Last successful fetch is persisted to Hive. Offline, cached data is served with an "offline" banner and a "last updated" timestamp; on reconnect the list auto‑refreshes. |

Also included: light/dark theming, English + Arabic localization (RTL), and responsive
sizing.

---

## Architecture


- **Five layers**, dependencies pointing inward only:
  `presentation → domain ← data`, with `core` / `shared` as leaf utilities.
  The domain layer is pure Dart (no Flutter, Dio, Hive, or JSON).
- **State management:** `flutter_bloc` — one Cubit per screen, immutable `freezed` state
  unions (`Initial | Loading | Loaded | Error`).
- **Error handling:** exceptions below the repository, a sealed `Result<T>` / `Failure`
  hierarchy at and above it; the repository is the single translation boundary.
- **Networking:** Dio behind an `ApiClient` abstraction, with retry / logging / error
  interceptors and a per‑date host resolved by `ApiConfig`.
- **DI:** manual `get_it` composition root (`core/di/injection.dart`), one
  `_register<Feature>()` per feature.



```
lib/
  app/          MaterialApp.router, go_router config, app‑level cubits (theme, connectivity)
  core/         network, error model, Result, DI, localization, network_info, currency catalog
  shared/       theme/design system, reusable widgets, extensions, formatters, responsive
  features/
    rates/            Module 1 + 3   (data / domain / presentation)
    currency_detail/  Module 2       (domain / presentation)
```

---

## Getting started

### Prerequisites

- **Flutter** 3.44+ (stable) — Dart SDK `^3.12.2`
- A device, emulator, or simulator (also runs on web/desktop)

Verify your toolchain:

```bash
flutter --version
flutter doctor
```

### Setup

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate freezed / json_serializable / Hive adapter code
dart run build_runner build --delete-conflicting-outputs
```

> Generated files (`*.freezed.dart`, `*.g.dart`) are committed, so step 2 is only needed
> after changing a model, state, or Hive adapter.

### Run

```bash
flutter run
```

No configuration or secrets are required — the API is fully open.

---

## Testing

```bash
# Run the full suite
flutter test

# With coverage
flutter test --coverage
```

Tests mirror `lib/` under `test/` and cover every layer — entity math and use cases
(domain), cache‑aside and exception→failure mapping (repository), DTO parsing and the EGP
inversion (data sources / mapper), exact state sequences via `bloc_test` (cubits), and
widget tests for color‑coding, states, shimmer, and pull‑to‑refresh. Coverage is weighted
toward the repository and Bloc layers, where the resilience logic lives 


