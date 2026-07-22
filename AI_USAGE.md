# AI Usage Log

I used AI (Claude, via Claude Code) as a pair programmer for this project — but in a
structured way, not one long chat. This document explains **how** I used it: a spec‑first
workflow, a team of specialized sub‑agents, how I prompt each one (context + rules + task),
and an honest log of the decisions where AI output was accepted, edited, or rejected.

---

## 1. How I used AI — a team of sub‑agents

Instead of asking one general assistant to build the whole app, I split the work the way a
real engineering team is split. Each part of the codebase has its own **sub‑agent**: a
saved role with a fixed job, a set of rules, and the exact folders it is allowed to touch.
The roles live in [`.claude/agents/`](.claude/agents/), and each agent works on its own
branch and ships one small PR.

Why do it this way instead of a single chat:

- **Focus** — each agent only sees its own job, so its answers stay on-topic and small.
- **Boundaries** — an agent that owns `domain/` is told it may never import Flutter or the
  data layer. This is how the architecture's dependency rule survives contact with AI.
- **Reviewable history** — one agent = one branch = one small PR, so every change is easy
  to read and revert. The `git log` shows 18 focused PRs, not one giant commit.

I stay in control: I write the task, review what comes back, edit or reject it, and I run
the tests. The final call on every merge is mine.

---

## 2. The sub‑agents

Ownership is **disjoint** — two agents never edit the same file, so their work can't
collide. The one shared file, `core/di/injection.dart`, is only extended with additive
`_register<Feature>()` functions.

| Sub‑agent | What it owns | Branch prefix |
|---|---|---|
| **platform-engineer** | App shell (`app/app.dart`), `go_router`, `NetworkInfo`, `ConnectivityCubit`, DI composition root | `feat/platform-*`, `refactor/app-*` |
| **domain-engineer** | Pure‑Dart domain: entities, repository interfaces, use cases. No Flutter/Dio/Hive | `feat/domain-*` |
| **data-engineer** | DTOs, mappers, remote (Dio) + local (Hive) data sources, repository impls, currency catalog | `feat/data-*` |
| **shared-ui-engineer** | Reusable, feature‑agnostic widgets (`LoadingView`, `ErrorView`, `ShimmerBox`, `OfflineBanner`…) built only from theme tokens | `feat/shared-ui-*` |
| **feature-ui-engineer** | Screens, feature widgets, and Cubits + freezed state for `rates` and `currency_detail` | `feat/rates-ui-*`, `feat/detail-ui-*` |
| **test-engineer** | Cross‑cutting test baseline + integration flow (list → detail → chart, offline path) | `test/*` |
| **qa-devops-engineer** | Lint boundary rules, CI, `README.md`, this `AI_USAGE.md` | `chore/*`, `ci/*`, `docs/*` |

---

## 3. Spec‑first workflow (and Spec Kit)

I don't let AI code straight from a one‑line request. I write the **spec first** — what to
build and how it should be structured — and only then let the AI implement against it. On
this project I wrote the architecture design and a PR breakdown up front, so the AI knew the
layering, the error boundary, and which folder it was allowed to touch before writing a line.

On other features I do the same thing with a tool: **GitHub Spec Kit**
(<https://github.com/github/spec-kit>), a toolkit for *Spec‑Driven Development*. It gives the
AI agent a fixed set of steps, each producing a document:

1. `/constitution` — the project's non‑negotiable principles (e.g. "domain is pure Dart").
2. `/specify` — **what** and **why**, no tech detail yet → `spec.md`.
3. `/plan` — **how**: stack, architecture, constraints → `plan.md`.
4. `/tasks` — break the plan into small, testable tasks → `tasks.md`.
5. `/implement` — the agent executes the tasks one by one.

Why I like it: it forces the *what* to be agreed before the *how*, keeps the AI from
inventing requirements, and leaves a paper trail (`spec.md` → `plan.md` → `tasks.md`) that
reviews just like code. I didn't run Spec Kit on this repo — I did the spec‑first flow by
hand because the design write‑up was itself part of the deliverable — but it's the tool I
reach for when a feature is large enough that the spec should be generated and tracked
formally rather than written prose‑style.

---

## 4. How I prompt — context + rules + task

A good prompt is not just "write me a mapper." I give the AI three things: the **rules** it
must follow, the **context** it needs, and the **task** itself. With the sub‑agent setup the
rules are permanent (baked into the agent file); I only add fresh context + the task each
time.
