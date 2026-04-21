# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter Android app **"ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী"** (FIFA World Cup 2026 Schedule BD) for Bangladeshi football fans. Package: `com.worldcup2026.bangladesh`. Flutter project root: `worldcup_2026_bd/`.

## Common Commands

All commands run from `worldcup_2026_bd/`:

```bash
flutter pub get                          # Install dependencies
flutter analyze                          # Lint (run after every change — must show 0 issues)
flutter run                              # Run on connected device/emulator
flutter build apk --release              # Build release APK
flutter build appbundle --release        # Build AAB for Play Store
flutter build apk --debug               # Build debug APK
```

## Architecture

```
lib/
├── main.dart / app.dart          — Entry point, MaterialApp, dark maroon theme, named routes
├── core/
│   ├── constants/                — app_colors.dart, app_text_styles.dart, app_strings.dart
│   ├── services/                 — standings_api.dart (football-data.org), cache_service.dart
│   └── utils/                   — number_to_bengali.dart (BengaliNumber), time_converter.dart (UTC→BST)
├── data/                         — Static Dart data files (matches, teams, groups, stadiums, history, players)
├── models/                       — Plain Dart model classes (no codegen)
├── screens/                      — One folder per screen; schedule/ has a widgets/ subfolder
└── widgets/                      — app_drawer.dart, countdown_timer_widget.dart (shared widgets)
```

All data is **static/hardcoded** in `data/` — no local database. Live standings come from `football-data.org` API with 5-min SharedPreferences cache.

## Key Design Constraints

**Color system** — Never use pure black (`#000000`) or pure white text. Use `AppColors` constants only:
- Background gradient: `#4a041c → #2d0211`
- App bar / cards: `#b00b46`
- Body text (bone white): `#f0dee1`
- Gold accents: `#FFD700` (VS text, badges, group headers)
- Cyan labels: `#00BCD4` (stadium names, info labels)

**Typography** — Bengali text must use `Hind Siliguri` with `height: 1.5` minimum (prevents vowel sign clipping). Use `AppTextStyles` constants. English numbers in Bengali context → convert with `BengaliNumber.convert()`.

**Design rules:**
- No 1px borders — use background color shifts for separation
- No `Divider()` widgets — use 8px vertical gaps
- Cards use `BorderRadius.circular(24)` (match/stadium: 16dp)
- Tap feedback: `InkWell` with scale to 95% or `GestureDetector` with `active:scale-95` equivalent

## Screen Inventory

| Screen | File | Status |
|---|---|---|
| Splash | `screens/splash/splash_screen.dart` | ✅ Done |
| Home | `screens/home/home_screen.dart` | ✅ Done |
| Match Schedule | `screens/schedule/schedule_screen.dart` | ✅ Done |
| Groups | `screens/groups/groups_screen.dart` | ✅ Done |
| Teams | `screens/teams/teams_screen.dart` | ✅ Done |
| Team Detail | `screens/teams/team_detail_screen.dart` | ✅ Done |
| Stadiums | `screens/stadiums/stadiums_screen.dart` | ✅ Done |
| Stadium Detail | `screens/stadiums/stadium_detail_screen.dart` | ✅ Done |
| Point Table | `screens/point_table/point_table_screen.dart` | ✅ Done |
| History | `screens/history/history_screen.dart` | ✅ Done |
| Players | `screens/players/players_screen.dart` | 🔲 Stub |
| Highlights | `screens/highlights/highlights_screen.dart` | 🔲 Stub |

## Pending Work (Step 12)

- **AdMob:** Banner on all screens (bottom fixed); Native every 8th match card, every 10th team card, after every 3rd group; Interstitial on Point Table entry (max 1/3 min). Use test IDs during dev.
- **Local notifications:** 30 min before each group-stage match, `flutter_local_notifications` + `timezone` (no Firebase).
- **5-star rating popup:** After 5th launch, or 2+ min session, or 10+ cards viewed.
- **App icon:** 512×512 PNG → `flutter_launcher_icons`.
- **HighlightsScreen / PlayersScreen:** Full implementation.

## AdMob Test IDs

| Type | ID |
|---|---|
| Banner | `ca-app-pub-3940256099942544/6300978111` |
| Interstitial | `ca-app-pub-3940256099942544/1033173712` |
| Native | `ca-app-pub-3940256099942544/2247696110` |

## Live API

- Endpoint: `https://api.football-data.org/v4/competitions/WC/standings`
- API Key: `4567397ae55147ce89a7a5f1d835e184`
- 5-min TTL cache via `CacheService` (SharedPreferences)
- On error: show cached data + Bengali "অফলাইন মোড" badge

## Android Config

- `minSdk = 21`, `targetSdk = 34`, `multiDexEnabled = true`
- `isCoreLibraryDesugaringEnabled = true` (required for `flutter_local_notifications`)
- Signing: currently uses debug keystore — add release signing before Play Store upload
- `assets/images/` and `assets/icons/` declared in pubspec

## Play Store Release

```bash
# Build signed AAB
flutter build appbundle --release

# Build signed APK (for sideload testing)
flutter build apk --release
```

Before release: add `signingConfig` in `android/app/build.gradle.kts` release build type, replace test AdMob IDs with real ones.
