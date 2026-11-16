# Tandem — Product Spec

> Working name: **Tandem**. A shared goal tracker for two people, with an iOS app and an iMessage extension.
> Status: draft v0.1 · Last updated: 2026-11-16

---

## 1. Overview

Tandem helps two partners track their own goals and shared goals. Each person can set any kind of goal (climbing, gym, tennis, cubing, LeetCode, steps, savings, reading…). Progress fills in automatically where possible (Apple Health, GitHub, LeetCode, Calendar). The two partners keep each other motivated through notifications and a playful iMessage extension.

### Goals of the product
- **Goal-driven:** every screen answers "How am I doing on what I said I'd do?"
- **Flexible:** one general goal model covers any hobby. No hard-coded sports.
- **Fun and social:** streaks, head-to-head challenges, cheers, celebrations, iMessage cards.
- **Low friction:** logging takes one tap, and integrations log for you.

### Non-goals (for now)
- No RPG mechanics (XP, levels, boss battles).
- No AI features in the MVP. The data model is designed so a cloud AI tracker builder can be added later (see §11).
- No groups larger than two people.
- No Android or web app.

---

## 2. Users

| Person | Example goals |
|---|---|
| Partner A | Gym 4x/week, tennis practice, cube ao12 under 20s, LeetCode daily, GitHub commits |
| Partner B | Climbing 3x/week, send a V5, daily steps |
| Shared | Combined 100k steps/week, climb together 1x/week, date night weekly |

---

## 3. Core concepts

### 3.1 Goal
A goal is built from a few general building blocks:

| Block | Options | Example |
|---|---|---|
| **Metric** | `check` (did it / didn't) · `count` · `duration` (minutes) · `value` (latest number) · `best` (best single result) | "Went climbing" · "LeetCode problems" · "Tennis minutes" · "Body weight" · "Cube PB" |
| **Target** | direction `atLeast` / `atMost` + value + period | ≥ 4 per week · ≤ 20 s (cube) |
| **Period** | `day` · `week` · `month` · `total` (to date / by deadline) | |
| **Deadline** | optional date | "Send a V5 by March 1" |
| **Source** | `manual` · `healthSteps` · `healthWorkouts` · `github` · `leetcode` · `calendar` | |
| **Ownership** | `personal` · `shared` (both contribute to one total) · `versus` (head-to-head) | |
| **Visibility** | `shared` (partner can see) · `private` | |
| **Custom fields** | per-entry fields: `picker(options)`, `number(unit)`, `text`, `toggle` | climbing grade, gym exercise, tennis drill |
| **Category** | one category (see §3.3) | |

There is no separate "habit" type. A habit is a goal with a `day` or `week` period.

**How progress is computed for a period:**
- `check`: number of distinct days with an entry
- `count`, `duration`: sum of entry values
- `value`: most recent entry
- `best`: min of entries if direction is `atMost` (lower is better, e.g. cube time), otherwise max

A goal is **met** for a period when progress satisfies the target. For `atMost` goals that use `best` or `value`, the goal counts as met only once at least one entry exists.

### 3.2 Log entry
`{ goal, user, date, value, fieldValues, note, source }`. Integrations create entries with `source` set, so manual and automatic entries are handled the same way.

### 3.3 Categories
Each goal has one category with a color and icon. The defaults are editable, and users can add, rename or delete categories:

💪 Health & Fitness · 🎾 Sports & Hobbies · 🧠 Learning · 🎓 Academic & Career · 💰 Financial · 🧘 Mind & Self-care · 💞 Relationship · 🏠 Life Admin

Users can also add optional free-form **tags**. Categories are used for grouping, the balance view, privacy defaults and notification muting.

### 3.4 Templates
Pre-built goals fill in the building blocks. Users can edit everything after picking one.

| Template | Metric | Target | Custom fields |
|---|---|---|---|
| Climbing sessions | count | ≥ 3 / week | grade (V0–V10), style (flash/redpoint/project) |
| Gym sessions | count | ≥ 4 / week | split (push/pull/legs/upper/lower/full) |
| Tennis practice | duration | ≥ 120 min / week | focus (serve/forehand/backhand/volley/match) |
| Cube PB | best | ≤ 20 s | event (3x3/2x2/OH) |
| Cube practice | count | ≥ 50 solves / week | — |
| LeetCode | count | ≥ 5 / week | difficulty (easy/medium/hard) · source: leetcode |
| GitHub commits | count | ≥ 1 / day | source: github |
| Daily steps | count | ≥ 8,000 / day | source: healthSteps |
| Read | duration | ≥ 20 min / day | — |
| Save money | value | ≥ $X total | — |
| Date night | check | ≥ 1 / week | shared |

---

## 4. Features

Priority: **P0** = MVP, **P1** = next, **P2** = later.

### 4.1 Goals and logging (P0)
- Create a goal from a template or from scratch.
- One-tap quick log (+1 / check). A log sheet handles value, custom fields and notes.
- Edit or delete entries, and archive or pause goals.
- Home screen: today's goals grouped by category, each with a progress ring.
- Goal detail: progress for the current period, history, streak and simple trend chart.

### 4.2 Streaks and celebration (P0)
- A streak counts consecutive periods where the goal was met. The current period doesn't break the streak until it ends.
- Celebrations: confetti and haptics when a goal is met or a personal best is set.
- **Milestone badges** tied to real achievements (100 sessions, first sub-20 solve, 30-day streak).
- **Streak freezes (P1):** 2 per month. A partner can gift one of theirs.

### 4.3 Partner features (P0 pairing, P1 extras)
- **Pairing (P0):** one partner creates an invite code or link, and the other accepts.
- **Partner feed (P0):** see your partner's shared goals and today's progress.
- **Cheers (P0):** react to a partner's entry (🔥 💪 👏 ❤️).
- **Shared goals (P0):** both partners' entries add up to one total.
- **Versus goals (P1):** head-to-head on the same metric, e.g. a weekly step duel.
- **Wagers (P1):** attach small stakes ("loser picks dinner"). The app tracks IOUs.
- **Copy partner's goal (P1)**, and **privacy per category** (e.g. Financial is private by default).

### 4.4 iMessage extension (P0 basic, P1 rich)
- **Check-in card (P0):** send "✅ Climbing — 3/3 this week 🔥 5-week streak" with an optional note.
- **Challenge card (P0):** "Bet you can't hit 3 gym sessions this week". Tapping Accept creates a versus goal.
- **Progress card (P1):** a live card that updates in the thread (MSSession).
- **Weekly recap card (P1):** each partner's wins, best streak and category balance.
- **Mini-games (P2):** cube race on the same scramble, spin-the-wheel for a daily challenge.
- The extension reads the same local store as the app through an App Group, so it doesn't need a network for basic cards.

### 4.5 Notifications and motivation (P0)
Written message packs, chosen by context and filled in with real stats. No AI.

| Trigger | Example |
|---|---|
| Streak at risk | "3 hours left to save your 12-day cubing streak 🔥" |
| Goal met | "Gym 4/4 this week. You did it 💪" |
| Partner completed | "She just sent a V5 🧗‍♀️ Your move." |
| Personal best | "New cube PB: 18.42s 🎉" |
| Morning summary | "3 goals today: steps, LeetCode, tennis." |
| Weekly recap | Sunday evening |

- **Custom messages:** partners write messages for each other that appear on specific triggers, like a note that shows when you finish leg day.
- **Settings:** quiet hours, mute by category, and a tone setting (hype / gentle / sarcastic).
- Local notifications handle your own reminders. Push notifications (APNs through the backend) handle partner events.

### 4.6 Insights (P1)
- **Category balance ring:** share of effort per category this week.
- Trends per goal (weekly totals, PB history, climbing grade pyramid).
- Shareable memory timeline of milestones (P2).

### 4.7 Widgets and Live Activities (P1)
- Home Screen and Lock Screen widgets showing today's goals and streak.
- A Live Activity for an active versus duel (P2).

---

## 5. Integrations

| Integration | Priority | How | Data |
|---|---|---|---|
| **Apple Health** | P0 | HealthKit (`HKStatisticsCollectionQuery`, background delivery) in the main app | steps, workouts (type, duration) → entries |
| **GitHub** | P0 | OAuth + GraphQL `contributionsCollection` (backend job) | daily contribution count |
| **LeetCode** | P1 | Unofficial public GraphQL (`matchedUser.submitStats`, `recentAcSubmissionList`) by username, run on the backend | problems solved by difficulty, daily |
| **Calendar** | P1 | EventKit (opt-in, read-first) | auto-log prompts from past events; optional time blocks for goals |
| **Garmin / other watches** | P2 | via Apple Health (no direct integration needed) | |

Notes:
- **LeetCode has no official API.** Keep that connector isolated behind a `SourceConnector` interface, and fail gracefully if it breaks.
- Integration entries are de-duplicated with a key (`source + externalID` or `source + date`). Re-syncing updates entries instead of duplicating them.
- Only the main app reads HealthKit. The extension reads the cached results from the App Group store.

---

## 6. Architecture

```
┌──────────────────────┐      ┌───────────────────────┐
│ iOS app (SwiftUI)    │      │ iMessage extension    │
│  - goals, logging    │      │  - compose/read cards │
│  - HealthKit, EventKit│     │                       │
└─────────┬────────────┘      └──────────┬────────────┘
          │      App Group shared store  │
          └───────────────┬──────────────┘
                          │  GoalKit (Swift package: models,
                          │  progress engine, templates,
                          │  messages, card payloads)
                          ▼
                ┌──────────────────────┐
                │ Backend (Supabase)   │
                │ Postgres + Auth +    │
                │ Realtime + Edge Fns  │
                │  - pairing, sync     │
                │  - APNs push         │
                │  - GitHub/LeetCode   │
                │    sync jobs (cron)  │
                └──────────────────────┘
```

- **Client:** SwiftUI, iOS 17+, Swift 6. Shared logic lives in the local Swift package `GoalKit`, which both targets use.
- **Local first:** the app works offline using the JSON store in the App Group container. Data syncs to the backend when online (P0 for pairing and partner data).
- **Backend:** Supabase is suggested (Postgres with row-level security, Sign in with Apple, realtime partner feed, Edge Functions for push and sync cron). Alternative: Firebase.
- **Push:** an Edge Function sends APNs when a partner logs, cheers, or completes a goal.

### 6.1 Data model (backend tables)
```
users(id, display_name, avatar_emoji, apns_token, tz)
pairs(id, user_a, user_b, created_at)
invites(code, from_user, expires_at)
categories(id, owner, name, emoji, color_hex, default_visibility)
goals(id, owner, pair_id?, name, emoji, category_id, metric, unit,
      target_direction, target_value, period, deadline?, source,
      ownership, visibility, fields jsonb, archived, created_at)
entries(id, goal_id, user_id, date, value, field_values jsonb,
        note, source, external_key unique?, created_at)
cheers(id, entry_id, from_user, emoji, created_at)
messages(id, from_user, to_user, trigger, text)   -- custom partner messages
connections(user_id, provider, username, token_ref, last_sync)
```
Row-level security: a user can read their own rows, plus rows where `visibility = shared` and they are in the same pair.

---

## 7. iMessage card payload

Cards encode a small payload in the `MSMessage.url` query string so they render without a network:

```
tandem://card?kind=checkIn&goal=Climbing&emoji=🧗‍♀️&progress=3&target=3&unit=sessions&streak=5&sender=Alex&note=...
```
`kind ∈ { checkIn, challenge, recap }`. Defined in `GoalKit/MessagePayload.swift`.

---

## 8. Privacy and security
- Health data stays on the device except for the aggregated numbers needed for shared or versus goals, and only with the user's consent.
- OAuth tokens (GitHub) are stored on the backend and never in the app bundle.
- Private goals never leave the device unless the user turns on backup.
- Users can delete their account and all data.

---

## 9. Milestones

| Milestone | Scope |
|---|---|
| **M0 — Scaffold** ✅ | Xcode project (app + iMessage extension), empty GoalKit package, CI |
| **M1 — Solo MVP** | Goal model, local store, templates, home/add/log screens, goal detail with history and streak, celebrations, local reminders, HealthKit steps, basic iMessage check-in card |
| **M2 — Together** | Supabase auth, pairing, sync, partner feed, cheers, shared goals, push |
| **M3 — Integrations** | GitHub, LeetCode, Calendar prompts |
| **M4 — Fun layer** | Versus goals, wagers, challenge accept flow, live iMessage cards, weekly recap, widgets |
| **M5 — Polish** | Streak freezes, badges, insights, custom messages, tone settings |

---

## 10. Open questions
- Final app name and bundle ID (currently placeholder `com.example.Tandem`).
- Supabase or Firebase?
- Should partners see each other's private goal *names*, or only that a private goal exists?
- How should time zones work for "day" if the partners live apart?

## 11. Future (out of scope for MVP)
- **AI tracker builder (cloud):** plain-English request → `Goal` JSON validated against the schema → preview → save. Works on any iPhone, because it runs on the server.
- **MCP server** on the backend (`create_goal`, `log_entry`, `get_progress`, `send_cheer`) with OAuth, so AI assistants can read and update goals.
- Natural-language logging, suggested targets, and AI-written recaps.
