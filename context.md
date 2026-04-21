# FIFA World Cup 2026 BD App — Session Context

## Project Goal
Build a production-ready Flutter Android app called **"ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী"** for Bangladeshi football fans, targeting Google Play Store.

- **Platform:** Flutter (Android)
- **Audience:** Bangladeshi football fans
- **Language:** Bengali (বাংলা) — Hind Siliguri font
- **Monetization:** Google AdMob
- **Package name:** `com.worldcup2026.bangladesh`

---

## Source Files Available

| File | Purpose |
|---|---|
| `FIFA2026_FINAL_MASTER_PROMPT.md` | Full app specification (930+ lines) |
| `stitch_designs/Home Screen/code.html` | Home screen HTML prototype |
| `stitch_designs/Home Screen/DESIGN.md` | Design system doc ("The Midnight Pitch") |
| `stitch_designs/Home Screen/screen.png` | Home screen screenshot |
| `stitch_designs/Teams All/code.html` | Teams list screen HTML prototype |
| `stitch_designs/Teams All/DESIGN.md` | Same design system doc |
| `stitch_designs/Teams All/screen.png` | Teams screen screenshot |
| `stitch_designs/navigation bar/code.html` | Navigation drawer HTML prototype |
| `stitch_designs/navigation bar/DESIGN.md` | Same design system doc |
| `stitch_designs/navigation bar/screen.png` | Drawer screenshot |
| `excel_data/FIFA2026_01_Teams_and_Groups.xlsx` | 48 teams, 12 groups (A–L) |
| `excel_data/FIFA2026_02_Historical_Winners.xlsx` | World Cup winners 1930–2022 |
| `excel_data/FIFA2026_03_Player_Squads.xlsx` | Player squads for all teams |
| `excel_data/FIFA2026_04_Stadiums.xlsx` | 17 stadiums data |
| `excel_data/FIFA_2026_সম্পূর্ণ_১০৪_ম্যাচ_Final.xlsx` | Complete 104-match schedule (BST) |
| `ফিফা_ওয়ার্ল্ড_কাপ_২০২৬_সময়সূচী.pdf` | Bengali schedule PDF |
| `ui_photos/photo_1..23.jpg` | 23 reference UI screenshots |

---

## Design System (Extracted from Stitch Files)

### Color Palette

#### App Bar / Drawer / Cards (Home Screen style)
| Role | Hex |
|---|---|
| Body background gradient | `#4a041c → #2d0211` |
| App bar & cards | `#b00b46` |
| Status bar | `#8a0636` |

#### Navigation Drawer colors
| Token | Hex | Usage |
|---|---|---|
| `brand` | `#880E4F` | Drawer background |
| `brand-dark` | `#560027` | Drawer footer bg |
| `brand-light` | `#BC477B` | Hover states, accents |

#### Teams Screen / Full Material Token System (dark mode)
| Token | Hex | Usage |
|---|---|---|
| `background` | `#1a1113` | App base background |
| `surface-container-low` | `#22191b` | Section backgrounds |
| `surface-container` | `#271d1f` | Card body |
| `surface-container-high` | `#31272a` | Primary cards |
| `surface-container-highest` | `#3d3234` | Card headers |
| `surface-bright` | `#413639` | Floating elements |
| `primary-container` | `#800021` | Hero gradients |
| `primary` | `#ffb3b5` | Buttons, icons, back arrow |
| `on-primary` | `#680019` | Text on primary buttons |
| `on-surface` | `#f0dee1` | Body text (warm bone white) |
| `on-surface-variant` | `#e0bfbf` | Secondary text |
| `outline-variant` | `#584141` | Ghost borders (max 15% opacity) |
| `tertiary-container` | `#c9a900` | "Live" chip |
| `secondary-container` | `#622599` | Unselected filter chips |
| `secondary` | `#ddb7ff` | Selected filter chips |
| `primary-fixed-dim` | `#ffb3b5` | Small captions subtle glow |

#### Master Prompt AppColors (Flutter dart values)
```dart
bgDark    = Color(0xFF560027)   // Main bg (darkest maroon)
bgMedium  = Color(0xFF880E4F)   // App bar, cards
bgCard    = Color(0xFF9C1A55)   // Match cards
pink      = Color(0xFFC2185B)   // Buttons, active tabs
pinkLight = Color(0xFFBC477B)   // Card label bars
gold      = Color(0xFFFFD700)   // Highlights, VS text, badges
cyan      = Color(0xFF00BCD4)   // Stadium names, info labels
white     = Color(0xFFFFFFFF)
textLight = Color(0xFFE0E0E0)
textGray  = Color(0xFFBDBDBD)
cardWhite = Color(0xFFFFFFFF)   // Teams list cards
cardBorder= Color(0xFFE0E0E0)   // Card borders
infoBg    = Color(0xFF7B1040)   // Info card background
infoIcon  = Color(0xFF8D4E35)   // Icon background (brownish)
```

### Typography
- **Bengali UI text:** `Hind Siliguri` (400, 600, 700)
- **Display/Headlines:** `Lexend` (scorelines, group letters)
- **Body/Titles:** `Plus Jakarta Sans` (stats, articles)
- **Bengali line-height:** minimum 1.5 (prevents vowel sign overlap)
- **Body text color:** `#f0dee1` — NOT pure white

### Shape / Border Radius
| Component | Radius |
|---|---|
| Home hero card | `24dp` (rounded-3xl) |
| Home grid cards | `24dp` (rounded-3xl) |
| Teams list cards | `24dp` (1.5rem — from Stitch) |
| Match cards | `16dp` |
| Stadium cards | `16dp` |
| Info cards | `12dp` |
| Buttons/pills | `28dp` |
| Tab active pill | `20dp` |

### Design Rules (from DESIGN.md — "The Midnight Pitch / Crimson Theatre")
1. **No 1px borders** — boundaries defined by background color shifts only
2. **No pure black (#000000)** — darkest is `#1a1113`
3. **No pure white text** — use `#f0dee1` (bone white) for body text
4. **No Material dividers** — use 8px vertical gaps instead
5. **Glassmorphism** for floating nav: 70% opacity + 20px backdrop blur
6. **Press feedback:** scale to 95% on tap (`active:scale-95`)
7. **Ambient glow shadows:** 32px blur, 0px offset, 6% opacity
8. **Ghost border fallback:** `outline-variant` at 15% opacity only

---

## Teams Screen Card Structure (Exact from Stitch)

```
┌──────────────────────────────────────────┐
│  [●flag 40×40 circular]  আর্জেন্টিনা    │
└──────────────────────────────────────────┘
```
- Layout: **horizontal** (flag + name side by side) — NOT vertical
- Background: `bg-white`
- Border radius: `24px` (rounded-[1.5rem])
- Padding: `p-4` (16px)
- Flag: `w-10 h-10`, `rounded-full` (circular), `border-slate-100`
- Name: `text-slate-900`, `font-bold`, `text-base` (16px), Hind Siliguri
- Press: `active:scale-95 transition-transform duration-200`

---

## Navigation Drawer Structure (Exact from Stitch)

- Width: 80% of screen
- Background: `#880E4F`
- Slides in from left

```
Header (pt-12 pb-8 px-6):
  "বিশ্বকাপ ২০২৬"  [✕ close button]
  "অফিসিয়াল অ্যাপ" (subtitle, brand-light color)
  border-b divider

Nav Items (px-6 py-4 each):
  [icon 24px]  সময়সূচী
  [icon 24px]  গ্রুপসমূহ
  [icon 24px]  দলসমূহ
  [icon 24px]  স্টেডিয়াম
  [icon 24px]  হাইলাইটস
  --- thin divider (border-brand-light/20) ---
  [star icon]  ৫ স্টার রেট দিন
  [share icon] অ্যাপটি শেয়ার করুন

Footer (bg: #560027 @ 40%, border-t):
  [warn icon]  বাগ রিপোর্ট করুন
  [chat icon]  মতামত ও পরামর্শ
  [gear]  সেটিংস  |  লগ আউট
```

- Hover: `bg-brand-light/10` = `#BC477B` at 10%
- Icons: white, 24px SVG

---

## App Architecture (Actual — as built)

```
lib/
├── main.dart                          ← App entry, theme
├── app.dart                           ← MaterialApp, routes, dark maroon theme
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            ← All color tokens
│   │   ├── app_text_styles.dart       ← Hind Siliguri, Lexend styles
│   │   └── app_strings.dart           ← All Bengali strings
│   └── utils/
│       ├── number_to_bengali.dart     ← BengaliNumber class (0→০)
│       └── time_converter.dart        ← UTC → BST helpers
├── data/
│   ├── matches_data.dart              ← 104 matches (BST pre-calculated)
│   ├── groups_data.dart               ← 12 groups × 4 teams
│   ├── teams_data.dart                ← 48 teams with flag emojis
│   ├── players_data.dart              ← Squad lists
│   ├── stadiums_data.dart             ← 17 stadiums
│   └── history_data.dart              ← 1930–2022 winners
├── models/
│   ├── match_model.dart
│   ├── team_model.dart
│   ├── player_model.dart
│   ├── stadium_model.dart
│   └── history_model.dart
├── screens/
│   ├── splash/splash_screen.dart      ✅ Full
│   ├── home/home_screen.dart          ✅ Full
│   ├── schedule/
│   │   ├── schedule_screen.dart       ✅ Full (Step 8)
│   │   └── widgets/match_card_widget.dart ✅ Full (Step 8)
│   ├── groups/groups_screen.dart      ✅ Full
│   ├── teams/
│   │   ├── teams_screen.dart          ✅ Full
│   │   └── team_detail_screen.dart    ✅ Full
│   ├── stadiums/
│   │   ├── stadiums_screen.dart       ✅ Full (Step 9)
│   │   └── stadium_detail_screen.dart ✅ Full (Step 9)
│   ├── point_table/point_table_screen.dart ✅ Full (Step 10)
│   ├── history/history_screen.dart    ✅ Full (Step 11)
│   ├── players/players_screen.dart    🔲 Stub
│   └── highlights/highlights_screen.dart 🔲 Stub
└── widgets/
    ├── app_drawer.dart                ✅ Full
    └── countdown_timer_widget.dart    ✅ Full

Not yet created (planned):
  core/services/ — notification_service.dart
  core/utils/ad_manager.dart
  widgets/ — ad_banner_widget.dart, rating_dialog.dart, loading_shimmer.dart
  screens/about/about_screen.dart
```

---

## Screens to Build (11 total)

| # | Screen | Status |
|---|---|---|
| 1 | Splash Screen | ✅ Done (Step 4) |
| 2 | Home Screen | ✅ Done (Step 6) |
| 3 | Navigation Drawer | ✅ Done (Step 5) |
| 4 | Match Schedule | ✅ Done (Step 8) |
| 5 | Groups Screen | ✅ Done (Step 7) |
| 6 | Teams Screen | ✅ Done (Step 7) |
| 7 | Team Detail Screen | ✅ Done (Step 7) |
| 8 | Stadiums Screen | ✅ Done (Step 9) |
| 9 | Stadium Detail Screen | ✅ Done (Step 9) |
| 10 | Point Table (Live API) | ✅ Done (Step 10) |
| 11 | History Screen | ✅ Done (Step 11) |
| 12 | Players Screen | ✅ Done (Session 3) |
| 13 | Highlights Screen | ✅ Done (Session 3) |

---

## Key Features to Implement

| Feature | Status | Notes |
|---|---|---|
| BST time conversion | ✅ Done | time_converter.dart + Bengali numeral display in match cards |
| Bengali numerals | ✅ Done | BengaliNumber class in number_to_bengali.dart |
| AdMob Banner | ✅ Session 3 | Home, Schedule, Teams, PointTable — adaptive bottom banner |
| AdMob Native | 🔲 Partial | Placeholder every 8th match card (not wired to real ad yet) |
| AdMob Interstitial | ✅ Session 3 | Point Table entry, max 1 per 3 minutes |
| Local notifications | ✅ Session 3 | 30 min before each group stage match, no Firebase |
| Live standings API | ✅ Step 10 | football-data.org free API, 5-min cache |
| 5-star rating popup | ✅ Session 3 | At launch 5/10/20, play store redirect on ≥4 stars |
| Offline mode | 🔲 Step 10 | Show cached data + "অফলাইন মোড" badge |
| Pull-to-refresh | 🔲 Step 10 | Point Table screen |

---

## pubspec.yaml Packages

```yaml
google_fonts: ^6.1.0
cached_network_image: ^3.3.1
carousel_slider: ^4.2.1
shimmer: ^3.0.0
lottie: ^3.0.0
provider: ^6.1.1
shared_preferences: ^2.2.2
http: ^1.1.0
connectivity_plus: ^5.0.2
google_mobile_ads: ^4.0.0
flutter_local_notifications: ^17.0.0
timezone: ^0.9.2
url_launcher: ^6.2.2
share_plus: ^7.2.1
intl: ^0.19.0
```

---

## AdMob Test IDs

| Type | Test ID |
|---|---|
| Banner | `ca-app-pub-3940256099942544/6300978111` |
| Interstitial | `ca-app-pub-3940256099942544/1033173712` |
| Native | `ca-app-pub-3940256099942544/2247696110` |

---

## Live API

- **Endpoint:** `https://api.football-data.org/v4/competitions/WC/standings`
- **API Key:** `4567397ae55147ce89a7a5f1d835e184`
- **Cache strategy:** 5-minute TTL via SharedPreferences
- **Fallback:** Show cached + "অফলাইন মোড" badge on error

---

## Play Store Info

| Field | Value |
|---|---|
| App name (Bengali) | ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী |
| App name (English) | FIFA World Cup 2026 Schedule BD |
| Package name | `com.worldcup2026.bangladesh` |
| Min SDK | 21 (Android 5.0) |
| Target SDK | 34 (Android 14) |
| Version | 1.0.0+1 |
| Category | Sports |

---

## Build Phases Checklist

### Phase 1 — Project Setup
- [x] `flutter create worldcup_2026_bd`
- [x] Update pubspec.yaml (all packages added)
- [x] Create AppColors, AppTextStyles, AppStrings
- [x] Build NavigationDrawer widget (`lib/widgets/app_drawer.dart`)
- [x] Configure AndroidManifest.xml, package name, min/target SDK

### Phase 2 — Static Data
- [x] Read Excel files → convert to Dart data classes
- [x] matches_data.dart (104 matches, BST pre-calculated)
- [x] teams_data.dart (48 teams, Bengali names + flag emojis)
- [x] players_data.dart
- [x] stadiums_data.dart (17 stadiums)
- [x] history_data.dart (1930–2022)
- [x] groups_data.dart (12 groups × 4 teams)

### Phase 3 — Screens
- [x] SplashScreen (animated trophy, particles, fade to home)
- [x] HomeScreen (hero card, 2×4 grid, today's matches, countdown)
- [x] CountdownTimerWidget (live ticking, Bengali numerals)
- [x] MatchScheduleScreen + 7 tabs + MatchCardWidget (Step 8)
- [x] GroupsScreen (groups A–L with gold headers + 2-col team cards)
- [x] TeamsScreen (2-col search, white cards, 48 teams)
- [x] TeamDetailScreen (hero header, position filter tabs, player list)
- [x] StadiumsScreen — Step 9 ✅
- [x] StadiumDetailScreen — Step 9 ✅
- [ ] HighlightsScreen — Step 12
- [x] HistoryScreen — Step 11 ✅
- [ ] PlayersScreen — Step 12

### Phase 4 — Live Features
- [x] football-data.org API (Point Table) — Step 10 ✅
- [ ] Local notifications — Step 12
- [x] Cache system (5-min TTL, SharedPreferences) — Step 10 ✅
- [x] Pull-to-refresh — Step 10 ✅

### Phase 5 — Monetization
- [ ] AdMob init — Step 12
- [ ] Banner ads — Step 12
- [ ] Native ads (placeholders already in lists) — Step 12
- [ ] Interstitial — Step 12

### Phase 6 — Polish & Publish
- [ ] 5-star rating popup — Step 12
- [ ] App icon (512×512) — Step 12
- [ ] Feature graphic (1024×500)
- [ ] Screenshots (4–8)
- [ ] Privacy Policy
- [ ] `flutter build apk --release`
- [ ] Sign APK, Play Store upload

---

## Flutter Project Location

```
E:/worldcup2026_app/worldcup_2026_bd/
```

---

## Session Log

### Session 1 — 2026-04-19
- Read and analyzed all source files
- Extracted complete color system, typography, spacing rules
- Created `context.md`

### Session 2 — 2026-04-20 (Steps 1–8)

**Steps 1–2:** Flutter project created, pubspec.yaml with all packages, AndroidManifest.xml, AppColors, AppTextStyles, AppStrings, BengaliNumber util, time_converter.dart, MaterialApp with dark maroon theme.

**Step 3:** Data layer — 6 data files + 5 model files from Excel (104 matches, 48 teams, 12 groups, 17 stadiums, history 1930–2022, player squads).

**Step 4:** Splash screen — animated trophy with floating gold particles, scale+fade+slide animations, navigates to HomeScreen after 2.8s.

**Step 5:** Navigation drawer — AppDrawer widget, 80% width, #880E4F bg, all nav items with icons, footer section.

**Step 6:** Home screen — gradient bg (#4a041c→#2d0211), hero card, 2×4 nav grid, "আজকের ম্যাচ" horizontal scroll, countdown timer widget; all stub screens created and wired.

**Step 7:** TeamsScreen (2-col white cards, search toggle, 48 teams), GroupsScreen (Groups A–L, gold headers, 2-col mini-cards), TeamDetailScreen (hero gradient header, group badge, position filter tabs, player cards).

**Step 8:** MatchScheduleScreen — 7 scrollable tabs (গ্রুপ স্টেজ | রাউন্ড অব ৩২ | রাউন্ড অব ১৬ | কোয়ার্টার ফাইনাল | সেমি ফাইনাল | তৃতীয় স্থান | ফাইনাল), gold-pill active tab indicator, real-time search bar in AppBar. MatchCardWidget: match#/group badges, flag emoji teams, gold VS, Bengali date+time with time-period prefix, cyan stadium row. Native ad placeholder every 8th card. TBD teams show "নির্ধারিত হবে".

**`flutter analyze` → No issues after every step.**

**Step 10:** PointTableScreen — 12 group tabs (A–L), live standings from football-data.org API with 5-min TTL cache (SharedPreferences), pull-to-refresh, "অফলাইন মোড" badge when serving cached/offline data, gold #1 / cyan #2 position badges, qualification legend, Bengali numeral stats table. New files: `standing_model.dart`, `core/services/standings_api.dart`, `core/services/cache_service.dart`. `flutter analyze` → No issues.

---

**Step 11:** HistoryScreen — `_buildWinCounts()` aggregates champions (West Germany grouped into Germany), `_WinCountCard` horizontal scroll with gold/silver/bronze rank borders + glow, `_HistoryCard` shows year (Lexend gold), host (cyan), champion vs runner-up (flag emoji + scores), 3rd place footer. Most recent (2022) shown first. `flutter analyze` → No issues.

---

---

### Session 4 — 2026-04-22 (Bug Fixes)

**All bugs from `bug fixing.md` fixed:**

- **Home layout (Bug 1):** "আজকের ম্যাচ" + countdown timer moved directly below hero card (ম্যাচ সময়সূচী), before the rest of the grid.
- **Remove Visiting Places (Bug 2):** "ভ্রমণ স্থান" menu card removed from grid. Grid now has 7 items.
- **Local asset images (Bug 3):** All grid cards now use `Image.asset` with local `assets/images/menu_*.png` files — instant load, no network dependency.
- **Flag emojis (Bug 4):** Fixed 7 countries with wrong `🏳️` emoji: বসনিয়া (🇧🇦), হাইতি (🇭🇹), যুক্তরাষ্ট্র (🇺🇸), কুরাসাও (🇨🇼), সুইডেন (🇸🇪), কেপ ভার্দে (🇨🇻), জর্ডান (🇯🇴).
- **Match card alignment (Bug 5):** Date/time + stadium rows now `mainAxisAlignment: center`, font size 12→13px. `Expanded` → `Flexible` for stadium text.
- **Point Table back button (Bug 6):** `leading: IconButton` with `arrow_back_ios_new_rounded` added to AppBar.
- **API auto-update (Bug 7):** Confirmed — no hardcoded stage filter in `standings_api.dart`. Auto-updates by live API.
- **Drawer navigation fixed (Bug 8):** Point Table + History screens now use `DrawerNavigator.navigate(context, route)` from new `core/utils/drawer_navigator.dart` utility. Uses `pushReplacement` with `MaterialPageRoute`.
- **History win count tap (Bug 9):** `_WinCountCard` wrapped in `GestureDetector`, onTap shows `SnackBar` with country + title count.
- **Settings/About screen (Bug 10):** Created `screens/about/about_screen.dart` with app name, version (1.0.0), platform, tournament info. Wired to drawer "সেটিংস" tap via `_handleDrawerRoute` in HomeScreen.
- **Highlights drawer item (fix):** Added missing `case 'highlights':` to HomeScreen's `_handleDrawerRoute`.
- **Ads restructured (Bug 11):** Removed fixed bottom `AdBannerWidget` from all Scaffold `bottomNavigationBar` slots. Now inline:
  - Schedule: after every 6th match card (real `AdBannerWidget`, replaces old placeholder)
  - History: after every 5th entry via `_buildHistoryDelegate`
  - Highlights: after every 3rd teaser card
  - Players screen: `AdManager.showInterstitial()` on entry
- **Logo added (Bug 12):** `assets/images/logo.png` shown in HomeScreen AppBar title with text fallback. Also in AboutScreen.
- **main.dart fix:** Fixed pre-existing `catchError` return type warning for AdMob init.
- **New files:** `lib/screens/about/about_screen.dart`, `lib/core/utils/drawer_navigator.dart`
- **`flutter analyze` → 0 issues**

---

### Session 3 — 2026-04-20 (Step 12 + Polish)

**Step 12 — Implemented:**

- **PlayersScreen** (`screens/players/players_screen.dart`): Full implementation — team filter chip row (19 teams with squads), position tabs (All/GK/DEF/MID/FWD), search bar, jersey-number sorted player cards with position color badges. `flutter analyze` → No issues.

- **HighlightsScreen** (`screens/highlights/highlights_screen.dart`): Tournament countdown with live ticking timer (days/hours/min/sec in Bengali numerals), feature teaser cards, host countries info. Shows "live highlights" UI once tournament starts (June 12, 2026). `flutter analyze` → No issues.

- **AdMob** (`core/services/ad_manager.dart` + `widgets/ad_banner_widget.dart`):
  - `AdManager` — loads/shows interstitial with 3-min cooldown
  - `AdBannerWidget` — adaptive banner, uses `bottomNavigationBar` slot
  - Banner added to: HomeScreen, ScheduleScreen, TeamsScreen, PointTableScreen
  - Interstitial shown on PointTableScreen entry (max once per 3 min)
  - Test IDs in use — replace with real IDs before release

- **Local Notifications** (`core/services/notification_service.dart`):
  - Initializes `flutter_local_notifications` + `timezone` (Asia/Dhaka)
  - Schedules reminders 30 min before all group-stage matches on app launch
  - Clears all previous notifications before re-scheduling

- **Rating Dialog** (`widgets/rating_dialog.dart` + `RatingHelper`):
  - SharedPreferences-based launch counter
  - Triggers at launch 5, 10, 20 (once dismissed "never ask" stops it)
  - 5-star tap → opens Play Store; ≤4 stars → no redirect
  - Shown automatically on HomeScreen via `addPostFrameCallback`

- **Share functionality**: Drawer "শেয়ার করুন" wired to `Share.share()` with Play Store URL.

- **main.dart**: Now awaits `MobileAds.instance.initialize()`, `NotificationService.init()`, `RatingHelper.incrementLaunch()`, and `NotificationService.scheduleGroupStageReminders()` before `runApp`.

- **pubspec.yaml**: Added `flutter_launcher_icons: ^0.14.3` to dev_dependencies + config block (`image_path: assets/images/app_icon.png`). Place a 512×512 PNG at that path then run `dart run flutter_launcher_icons` to apply.

- **build.gradle.kts**: Added commented signing config template with keytool instructions. Uncomment + fill `android/key.properties` before release build.

- **CLAUDE.md**: Created at repo root.

**flutter analyze → No issues (0 warnings/errors)**

---

## Release Checklist

### Before building APK/AAB
- [ ] Replace AdMob test IDs with real production IDs in `core/services/ad_manager.dart`
- [ ] Replace test AdMob App ID in `AndroidManifest.xml` (meta-data `APPLICATION_ID`)
- [ ] Create a 512×512 PNG app icon at `assets/images/app_icon.png` and run `dart run flutter_launcher_icons`
- [ ] Generate signing keystore: `keytool -genkey -v -keystore android/app/worldcup2026.jks -alias worldcup2026 -keyalg RSA -keysize 2048 -validity 10000`
- [ ] Create `android/key.properties` (see comments in `build.gradle.kts`), add to `.gitignore`
- [ ] Uncomment release signing config in `android/app/build.gradle.kts`

### Build commands (from `worldcup_2026_bd/` directory)
```bash
flutter build apk --release          # Signed APK for device testing
flutter build appbundle --release    # Signed AAB for Play Store upload
```

### Open in Android Studio
1. Open Android Studio → "Open" → select `E:/worldcup2026_app/worldcup_2026_bd/`
2. Wait for Gradle sync to complete
3. Connect device via USB (enable USB debugging) or start an emulator
4. Run → Run 'main.dart'  — or —  Build → Build Bundle(s) / APK(s)
