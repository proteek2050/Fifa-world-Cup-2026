# 🏆 ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী — FINAL MASTER PROMPT
## For: Antigravity + Claude Terminal | Flutter Android App | Google Play Store

---

> ### 📁 My Folder Structure
> ```
> /worldcup2026_app/
> ├── stitch_designs/
> │   ├── Home Screen/          ← index.html, design.md, preview.jpg
> │   ├── Teams All/            ← index.html, design.md, preview.jpg
> │   └── navigation bar design/ ← index.html, design.md, preview.jpg
> ├── excel_data/
> │   ├── FIFA2026_সম্পূর্ণ_১০৪_ম্যাচ_Final.xlsx
> │   ├── FIFA2026_01_Teams_and_Groups.xlsx
> │   ├── FIFA2026_02_Historical_Winners.xlsx
> │   ├── FIFA2026_03_Player_Squads.xlsx
> │   └── FIFA2026_04_Stadiums.xlsx
> ├── ui_photos/                ← Reference app screenshots
> └── ফিফা_ওয়ার্ল্ড_কাপ_২০২৬_সময়সূচী.pdf
> ```

---
```

---

## 🚀 MASTER PROMPT — FULL VERSION

### ROLE & MISSION
```
You are a world-class Flutter developer and mobile UI/UX expert.
Your mission: Build a production-ready, Play Store-ready Android app
called "ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী" for Bangladeshi football fans.

CRITICAL RULES:
1. READ all files in stitch_designs/ first — replicate the UI EXACTLY
2. READ all Excel files — use this data, do NOT invent data
3. ALL UI text must be in Bengali (বাংলা) using Hind Siliguri font must
4. ALL match times must show Bangladesh Standard Time (BST = UTC+6)
5. ZERO lag, ZERO jitter — performance is top priority
6. The app earns money via AdMob — implement ads SMARTLY (not annoyingly)
```

---

## 📐 DESIGN SYSTEM (From Stitch Files — DO NOT CHANGE)

### Colors — এগুলো Stitch থেকে নেওয়া, পরিবর্তন করবে না
```dart
class AppColors {
  // Background
  static const Color bgDark    = Color(0xFF560027);  // Main bg (darkest maroon)
  static const Color bgMedium  = Color(0xFF880E4F);  // App bar, cards
  static const Color bgCard    = Color(0xFF9C1A55);  // Match cards
  
  // Accent
  static const Color pink      = Color(0xFFC2185B);  // Buttons, active tabs
  static const Color pinkLight = Color(0xFFBC477B);  // Card label bars
  static const Color gold      = Color(0xFFFFD700);  // Highlights, VS text, badges
  static const Color cyan      = Color(0xFF00BCD4);  // Stadium names, info labels
  
  // Text
  static const Color white     = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFE0E0E0);
  static const Color textGray  = Color(0xFFBDBDBD);
  
  // Cards (from Teams screen)
  static const Color cardWhite = Color(0xFFFFFFFF);  // Teams list cards
  static const Color cardBorder= Color(0xFFE0E0E0);  // Card borders
  
  // Info cards (from Stadium Detail)
  static const Color infoBg    = Color(0xFF7B1040);  // Info card background
  static const Color infoIcon  = Color(0xFF8D4E35);  // Icon background (brownish)
}
```

### Typography
```dart
// pubspec.yaml এ যোগ করতে হবে:
// google_fonts: ^6.1.0

TextStyle get titleStyle => GoogleFonts.hindSiliguri(
  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white);

TextStyle get bodyStyle => GoogleFonts.hindSiliguri(
  fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textLight);

TextStyle get cardLabelStyle => GoogleFonts.hindSiliguri(
  fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);

TextStyle get badgeStyle => GoogleFonts.hindSiliguri(
  fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.bgDark);
```

### Shapes (Stitch থেকে exact values)
```
Home grid cards:     BorderRadius.circular(24)  ← rounded-3xl
Teams list cards:    BorderRadius.circular(16)  ← rounded-2xl  
Match cards:         BorderRadius.circular(16)
Stadium cards:       BorderRadius.circular(16)
Info cards:          BorderRadius.circular(12)
Buttons/pills:       BorderRadius.circular(28)
Tab active pill:     BorderRadius.circular(20)
```

---

## 📱 APP ARCHITECTURE

```
lib/
├── main.dart                    ← App entry, AdMob init, theme
├── app.dart                     ← MaterialApp, routes
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_strings.dart     ← সব Bengali strings
│   ├── utils/
│   │   ├── time_converter.dart  ← UTC → BST
│   │   ├── number_to_bengali.dart ← 1 → ১
│   │   └── ad_manager.dart      ← Smart AdMob manager
│   └── services/
│       ├── standings_api.dart   ← football-data.org API
│       ├── cache_service.dart   ← SharedPreferences cache
│       └── notification_service.dart ← Local notifications
│
├── data/
│   ├── matches_data.dart        ← 104 matches (from Excel)
│   ├── groups_data.dart         ← 12 groups × 4 teams
│   ├── teams_data.dart          ← 48 teams
│   ├── players_data.dart        ← Squad lists (from Excel)
│   ├── stadiums_data.dart       ← 17 stadiums
│   └── history_data.dart        ← 1930-2022 winners
│
├── models/
│   ├── match_model.dart
│   ├── team_model.dart
│   ├── player_model.dart
│   ├── stadium_model.dart
│   └── standing_model.dart
│
├── screens/
│   ├── splash/splash_screen.dart
│   ├── home/home_screen.dart
│   ├── schedule/
│   │   ├── schedule_screen.dart
│   │   └── widgets/match_card_widget.dart
│   ├── groups/groups_screen.dart
│   ├── teams/
│   │   ├── teams_screen.dart
│   │   └── team_detail_screen.dart
│   ├── stadiums/
│   │   ├── stadiums_screen.dart
│   │   └── stadium_detail_screen.dart
│   ├── players/players_screen.dart
│   ├── point_table/point_table_screen.dart
│   ├── history/history_screen.dart
│   └── about/about_screen.dart
│
└── widgets/
    ├── nav_drawer.dart
    ├── ad_banner_widget.dart
    ├── countdown_timer_widget.dart
    ├── rating_dialog.dart        ← 5-star popup
    └── loading_shimmer.dart
```

---

## 🏠 SCREEN 1: SPLASH SCREEN

```dart
// Duration: 1.5 seconds
// Background: gradient #560027 → #C2185B
// Center: Trophy SVG icon + "ফিফা ওয়ার্ল্ড কাপ ২০২৬" text
// Animation: fade in + scale up (300ms)
// Then navigate to HomeScreen
// On first launch: schedule local notifications for upcoming matches
```

---

## 🏠 SCREEN 2: HOME SCREEN
### (Replicate stitch_designs/Home Screen/index.html EXACTLY)

```
APP BAR:
  - Background: #880E4F (solid, no elevation shadow)
  - Left: Hamburger icon → opens NavigationDrawer
  - Center: "বিশ্বকাপ ফুটবল সময়সূচী ২০২৬" (Hind Siliguri Bold, 18sp, white)
  - No right icons

BODY (scrollable, bg: #560027):

1. HERO BANNER CAROUSEL (height: 200dp)
   - Auto-scroll every 4s with smooth animation
   - 4 slides:
     Slide 1: FIFA 2026 logo + "আমেরিকা, কানাডা, মেক্সিকো" text
     Slide 2: Messi (Argentina jersey) + Ronaldo (Portugal jersey) image
     Slide 3: Neymar (Brazil) + Mbappé (France) image  
     Slide 4: Trophy image
   - Dark gradient overlay (bottom 50%)
   - White dot indicators at bottom center

2. GRID MENU (2 columns, 12dp padding each side)
   Structure from Stitch (EXACT):
   
   Row 1 — 2 cards:
   ┌──────────────────────┐  ┌──────────────────────┐
   │ [football draw img]  │  │ [players collage img] │
   │                      │  │                       │
   │  ██ গ্রুপসমূহ       │  │  ██ দলসমূহ           │
   └──────────────────────┘  └──────────────────────┘
   
   Row 2 — 2 cards:
   ┌──────────────────────┐  ┌──────────────────────┐
   │ [stadium aerial img] │  │ [city/skyline img]    │
   │                      │  │                       │
   │  ██ স্টেডিয়াম      │  │  ██ ভ্রমণ স্থান      │
   └──────────────────────┘  └──────────────────────┘
   
   Row 3 — 2 cards:
   ┌──────────────────────┐  ┌──────────────────────┐
   │ [players group img]  │  │ [football match img]  │
   │                      │  │                       │
   │  ██ খেলোয়াড়        │  │  ██ হাইলাইটস         │
   └──────────────────────┘  └──────────────────────┘
   
   Row 4 — 2 cards:
   ┌──────────────────────┐  ┌──────────────────────┐
   │ [chart/stats img]    │  │ [trophy history img]  │
   │                      │  │                       │
   │  ██ পয়েন্ট টেবিল   │  │  ██ ইতিহাস           │
   └──────────────────────┘  └──────────────────────┘
   
   ALSO add at top (full width):
   ┌────────────────────────────────────────────────┐
   │ [schedule/calendar img - full width]           │
   │                                                │
   │  ██ ম্যাচ এবং সময়সূচী (center aligned)      │
   └────────────────────────────────────────────────┘

   Card Specs:
   - Height: 160dp (image 120dp + label bar 40dp)
   - Border radius: 24dp
   - Image: cover fit, with subtle dark overlay
   - Label bar: background #BC477B, text white bold 16sp
   - Tap → ripple effect → navigate to screen

3. "আজকের ম্যাচ" SECTION (below grid)
   - Title: "আজকের ম্যাচ" (gold #FFD700, bold, 18sp)
   - Horizontal scrollable mini match cards
   - Each card (160dp × 90dp):
     Flag (24dp) + টিম name + VS + Flag + টিম name
     Date + Time (BST, small)
     Background: #9C1A55, radius 12dp
   - If no matches today: "আজ কোনো ম্যাচ নেই 😔" (gray, center)

4. COUNTDOWN TIMER (if tournament not started)
   - "পরবর্তী ম্যাচ শুরু হতে আর"
   - DD দিন : HH ঘণ্টা : MM মিনিট : SS সেকেন্ড
   - Background: semi-transparent dark card
   - Animated digit flip effect

5. ADMOB BANNER (bottom, fixed)
   - AdaptiveBanner, always visible
   - Test ID: ca-app-pub-3940256099942544/6300978111
```

---

## 📋 SCREEN 3: NAVIGATION DRAWER
### (Replicate stitch_designs/navigation bar design/index.html EXACTLY)

```
DRAWER HEADER:
  - Background: #880E4F (solid)
  - Top padding: 48dp (status bar)
  - Title: "World Cup Schedule 2026" (Bold, white, 22sp) ← keep English OR
            "বিশ্বকাপ ২০২৬" (যদি বাংলা করেন)
  - Subtitle: line separator below title

MENU ITEMS (Icon + Label):
  ── মূল বিভাগ ──
  📅  সময়সূচী          → ScheduleScreen
  👥  গ্রুপসমূহ        → GroupsScreen
  🌍  দলসমূহ           → TeamsScreen
  🏟  স্টেডিয়াম        → StadiumsScreen
  📊  হাইলাইটস         → HighlightsScreen (YouTube links)
  
  ── অন্যান্য ──
  ⭐  Rate 5 Star       → Play Store rating intent
  📤  Share App         → Share deep link
  💬  Feedback          → Email intent
  🐛  Report Bug        → Email intent
  ℹ️  About             → AboutScreen

ITEM STYLE (from Stitch):
  - Background: #880E4F
  - Icon color: white, 24dp
  - Text: white, Hind Siliguri, 16sp
  - Active item: slightly lighter background #9C1A55
  - Divider: thin line #9C2060 between sections
  - No elevation, flat style
```

---

## 📅 SCREEN 4: MATCH SCHEDULE

```
APP BAR: "ম্যাচ এবং সময়সূচী"

TAB BAR (horizontally scrollable, sticky):
  Active:   Yellow pill (#FFD700), dark text, bold
  Inactive: White text, transparent bg
  Tabs: গ্রুপ স্টেজ | রাউন্ড অব ৩২ | রাউন্ড অব ১৬ | কোয়ার্টার ফাইনাল | সেমি ফাইনাল | ফাইনাল

MATCH CARD WIDGET (from Excel data):
┌──────────────────────────────────────────────┐
│  [ম্যাচ ১] (yellow pill)   [গ্রুপ A] (cyan) │
│                                              │
│   🇲🇽  মেক্সিকো    VS    দক্ষিণ আফ্রিকা  🇿🇦 │
│        (flag 36dp)   ↑     (flag 36dp)      │
│                    Gold                     │
│                                              │
│      📅 ১২ জুন ২০২৬ — রাত ০১:০০ (BST)     │
│      🏟 Estadio Azteca (Cyan)               │
│         মেক্সিকো সিটি, মেক্সিকো            │
└──────────────────────────────────────────────┘
Card bg: #9C1A55 | Radius: 16dp | Margin: 12h 8v

NATIVE AD every 8th card (same size as match card, themed)

KNOCKOUT STAGE cards show "নির্ধারিত হবে" for TBD teams

SEARCH BAR (top):
  - Search by: দলের নাম, স্টেডিয়াম, তারিখ
  - Real-time filter
  - Background: slightly lighter than bg
```

---

## 👥 SCREEN 5: GROUPS (গ্রুপসমূহ)

```
APP BAR: "গ্রুপ সমূহ"

Body: ScrollView
  For each group A→L:
  
  SECTION HEADER:
    "গ্রুপ A" — Yellow #FFD700, Bold, 18sp
    Thin cyan line separator below
  
  2-COLUMN TEAM GRID:
  ┌──────────────────┐  ┌──────────────────┐
  │ [flag 32dp]      │  │ [flag 32dp]      │
  │ মেক্সিকো        │  │ দক্ষিণ আফ্রিকা  │
  └──────────────────┘  └──────────────────┘
  Card: white bg, border #E0E0E0, radius 12dp
  Flag: rectangular, 32×22dp
  Name: dark text, 13sp, center, Hind Siliguri
  Tap → TeamDetailScreen

NATIVE AD after every 3rd group
```

---

## 🌍 SCREEN 6: TEAMS (দলসমূহ)
### (Replicate stitch_designs/Teams All/index.html EXACTLY)

```
APP BAR: "দলসমূহ" (← back arrow)

Body: ListView (scrollable)
  2-COLUMN GRID, all 48 teams alphabetically in Bengali:

  ┌──────────────────────┐  ┌──────────────────────┐
  │  [🇩🇿 flag 40dp]    │  │  [🇦🇷 flag 40dp]    │
  │                      │  │                      │
  │    আলজেরিয়া         │  │    আর্জেন্টিনা       │
  └──────────────────────┘  └──────────────────────┘

  Card specs (from Stitch):
  - Background: White #FFFFFF
  - Border: 1dp, #E0E0E0
  - Border radius: 16dp
  - Height: 90dp
  - Flag: centered top, 40dp height
  - Team name: Bengali, dark (#111), 14sp bold, center bottom
  - Tap → ripple → TeamDetailScreen

NATIVE AD every 10th card (same card size)
```

---

## 👤 SCREEN 7: TEAM DETAIL (খেলোয়াড়)

```
APP BAR: "[দলের নাম বাংলায়]" + back arrow

HEADER:
  - Large flag image (full width, 140dp)
  - Team name: Bold, 24sp, white
  - "বিশ্বকাপ দল ২০২৬" subtitle: gray, 14sp
  - Group badge: "গ্রুপ A" cyan pill

POSITION FILTER TABS:
  [সকলে] [গোলরক্ষক] [ডিফেন্ডার] [মিডফিল্ডার] [ফরোয়ার্ড]
  Horizontal scrollable pills

PLAYER LIST:
  Each row alternating white / #F8F8F8:
  ┌────────────────────────────────────────┐
  │  ১০  লিওনেল মেসি          [ক্যাপ্টেন]│
  │       ফরোয়ার্ড                        │
  └────────────────────────────────────────┘
  Number: colored circle (#C2185B)
  Name: Bengali, bold, 15sp
  Position: gray, 12sp
  Captain badge: gold, small

DATA SOURCE: excel_data/FIFA2026_03_Player_Squads.xlsx
```

---

## 🏟 SCREEN 8: STADIUMS (স্টেডিয়াম)
### (Based on Stitch screenshots — already designed)

```
APP BAR: "স্টেডিয়াম"

Body: ListView of full-width cards

EACH STADIUM CARD (height: 180dp):
  ┌─────────────────────────────────────────┐
  │  [Real aerial stadium photo - 180dp]    │
  │                                         │
  │  ██ GRADIENT OVERLAY (bottom 50%)      │
  │                                         │
  │  Estadio Azteca        (white, bold)    │
  │  Mexico City, Mexico   (gray, 13sp)     │
  └─────────────────────────────────────────┘
  Border radius: 16dp
  Tap → StadiumDetailScreen

IMAGE URLS (Wikimedia Commons, free):
  Estadio Azteca:     wikipedia aerial photo URL
  MetLife Stadium:    wikipedia aerial photo URL
  [... use CachedNetworkImage with placeholder]

DATA: excel_data/FIFA2026_04_Stadiums.xlsx
```

---

## 🏟 SCREEN 9: STADIUM DETAIL
### (Replicate Stitch screenshot EXACTLY)

```
BODY (no app bar, back overlay):
  [Full-width hero image, 220dp]
  ← back arrow (white, top-left overlay, 16dp margin)

  Stadium name: White, Bold, 28sp (auto-size for long names)
  City: Cyan #00BCD4, 16sp

  INFO CARDS (from Stitch — brownish icon bg, yellow title):
  ┌────────────────────────────────────────────┐
  │ [📍 icon bg #8D4E35]  অবস্থান (yellow)    │
  │                        Mexico City, Mexico │
  └────────────────────────────────────────────┘
  ┌────────────────────────────────────────────┐
  │ [🪑 icon bg #8D4E35]  ধারণক্ষমতা (yellow) │
  │                        ৮৭,৫২৩ আসন        │
  └────────────────────────────────────────────┘
  ┌────────────────────────────────────────────┐
  │ [📅 icon bg #8D4E35]  উদ্বোধন (yellow)    │
  │                        ১৯৬৬               │
  └────────────────────────────────────────────┘
  ┌────────────────────────────────────────────┐
  │ [⚽ icon bg #8D4E35]  ফিক্সচার (yellow)   │
  │                        ৩টি গ্রুপ + ১ R32  │
  └────────────────────────────────────────────┘

  "স্টেডিয়াম সম্পর্কে" (Cyan, Bold, 16sp)
  [Description paragraph — from Excel]

  Card bg: #7B1040 | Radius: 12dp | Margin: 16dp
```

---

## 📊 SCREEN 10: POINT TABLE (পয়েন্ট টেবিল)

```
APP BAR: "পয়েন্ট টেবিল"

⚡ LIVE DATA: football-data.org API (free, no server needed)
   API endpoint: https://api.football-data.org/v4/competitions/WC/standings
   API Key: (User registers free at football-data.org → gets key)
   Competition code: WC (FIFA World Cup)
   
   IMPLEMENTATION:
   1. App launches → check cache age
   2. If cache < 5 min → show cache
   3. If cache ≥ 5 min → fetch fresh data
   4. Show "শেষ আপডেট: X মিনিট আগে"
   5. Pull-to-refresh supported
   6. On error → show cached data + "অফলাইন মোড" badge

```dart
// standings_api.dart
class StandingsService {
  static const String baseUrl = 'https://api.football-data.org/v4';
  static const String apiKey = '4567397ae55147ce89a7a5f1d835e184';
  
  Future<List<GroupStanding>> fetchStandings() async {
    final response = await http.get(
      Uri.parse('$baseUrl/competitions/WC/standings'),
      headers: {'X-Auth-Token': apiKey},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return _parseStandings(data);
    }
    throw Exception('API Error');
  }
}
```

TABLE DESIGN (per group):
  "গ্রুপ A" header (yellow, bold)
  
  ┌────┬────────────┬────┬──┬──┬──┬────┬────┬────┬────┐
  │    │ দল         │ খে │ জ│ড │ হ │ গো+│ গো-│ গোব│ পয়│
  ├────┼────────────┼────┼──┼──┼──┼────┼────┼────┼────┤
  │ 🇲🇽│ মেক্সিকো  │ ০  │০ │০ │০ │ ০  │ ০  │ ০  │ ০  │
  └────┴────────────┴────┴──┴──┴──┴────┴────┴────┴────┘
  
  Column: দল (Team) | খেলা (MP) | জয় (W) | ড্র (D) | হার (L)
          গোল+ (GF) | গোল- (GA) | গোব্যব (GD) | পয়েন্ট (Pts)
  
  Top 2 teams: green left border
  Eliminated: gray text
  
BEFORE TOURNAMENT STARTS: show all zeros
INTERSTITIAL AD when entering this screen (max 1/3 min)
```

---

## 🏆 SCREEN 11: HISTORY (ইতিহাস)

```
APP BAR: "কে কতবার বিজয়ী" (Blue bg #1565C0 — matches reference PDF)

WINNER CARDS (white, shadow):
┌──────────────────────────────────────────┐
│  [🇧🇷 flag 48×32]   ব্রাজিল             │
│                                          │
│  উইনার্স: ৫ বার     ⭐⭐⭐⭐⭐           │
│           রানার্স-আপ: ২ বার             │
└──────────────────────────────────────────┘

Then: "সম্পূর্ণ ইতিহাস" section
Year | Host | Champion | Runner-up | Score
(scrollable table, from Historical_Winners.xlsx)

DATA: excel_data/FIFA2026_02_Historical_Winners.xlsx
```

---

## ⭐ 5-STAR RATING POPUP SYSTEM

```dart
// rating_dialog.dart — Smart timing, not annoying
class RatingManager {
  static const int _launchThreshold  = 5;   // 5th launch দেখাবে
  static const int _sessionThreshold = 3;   // min 3 sessions পর
  static const int _cooldownDays     = 7;   // একবার dismiss করলে 7 দিন পর আবার
  
  // Trigger timing:
  // 1. On 5th app launch (never before)
  // 2. After user spends 2+ minutes in app
  // 3. After viewing 10+ match cards (engaged user)
  // 4. NOT during ad display
  // 5. NOT within 2 seconds of screen change
  
  static Future<void> checkAndShow(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final launches = prefs.getInt('launch_count') ?? 0;
    final rated = prefs.getBool('has_rated') ?? false;
    final lastShown = prefs.getInt('last_rating_shown') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final cooldown = Duration(days: _cooldownDays).inMilliseconds;
    
    if (!rated && launches >= _launchThreshold && 
        (now - lastShown) > cooldown) {
      await prefs.setInt('last_rating_shown', now);
      _showRatingDialog(context);
    }
  }
}

// Dialog Design:
// - Trophy emoji big center
// - "আপনি কি এই অ্যাপটি উপভোগ করছেন?"
// - 5 star buttons (tap to select)
// - "রেটিং দিন" button → Play Store intent
// - "পরে" → dismiss (shows again in 7 days)
// - "না, ধন্যবাদ" → never show again
```

---

## 💰 ADMOB — SMART AD STRATEGY

```
PHILOSOPHY: User experience FIRST. Ads visible but never blocking.

1. ADAPTIVE BANNER (bottom, always visible)
   - Every screen has bottom banner
   - Height auto-adjusts to screen width
   - Does NOT overlap content (add bottom padding)

2. NATIVE ADS IN LISTS (best UX, feels natural)
   - Match Schedule: every 8th card replaced by native ad
   - Groups screen: after every 3rd group
   - Teams screen: every 10th team card
   - Native ad styled to match app theme (maroon bg)

3. INTERSTITIAL (full-screen, occasional)
   - Triggers: Enter Point Table screen
   - Frequency: MAX 1 per 3 minutes (enforce with timer)
   - NOT on: back button, drawer open, team list navigation
   - Show loading → then content (don't block data display)

4. NO rewarded ads (not needed for this app type)

ADMOB TEST IDs (use during development):
  Banner:        ca-app-pub-3940256099942544/6300978111
  Interstitial:  ca-app-pub-3940256099942544/1033173712
  Native:        ca-app-pub-3940256099942544/2247696110

PRODUCTION: Replace with real AdMob unit IDs from AdMob console
```

---

## 🔔 LOCAL NOTIFICATIONS (No Firebase needed!)

```dart
// notification_service.dart
// Uses: flutter_local_notifications package
// No server, no Firebase, 100% offline capable

class NotificationService {
  // Schedule on first app launch:
  // For each of 72 group stage matches:
  //   → Schedule notification 30 min before BST kickoff
  //   → Title: "⚽ ম্যাচ শুরু হতে ৩০ মিনিট বাকি!"
  //   → Body: "মেক্সিকো 🆚 দক্ষিণ আফ্রিকা | রাত ০১:০০ BST"
  
  // Cancel all → Reschedule if user clears notifications
  
  static Future<void> scheduleMatchReminders() async {
    for (final match in MatchData.groupStageMatches) {
      final bstTime = TimeConverter.utcToBST(match.utcTime);
      final notifyTime = bstTime.subtract(const Duration(minutes: 30));
      
      if (notifyTime.isAfter(DateTime.now())) {
        await _scheduleNotification(
          id: match.matchNo,
          title: '⚽ ম্যাচ শুরু হতে ৩০ মিনিট!',
          body: '${match.homeTeamBn} 🆚 ${match.awayTeamBn}',
          scheduledTime: notifyTime,
        );
      }
    }
  }
}
```

---

## ⚡ PERFORMANCE OPTIMIZATION (Zero Lag)

```dart
// 1. Use const constructors everywhere possible
const Text('ম্যাচ', style: TextStyle(...))

// 2. ListView.builder (never ListView with children[])
ListView.builder(
  itemCount: matches.length,
  itemBuilder: (ctx, i) => MatchCard(match: matches[i]),
)

// 3. RepaintBoundary for animated widgets
RepaintBoundary(child: CountdownTimer())

// 4. Image caching
CachedNetworkImage(
  imageUrl: flagUrl,
  placeholder: (ctx, url) => const FlagPlaceholder(),
  errorWidget: (ctx, url, e) => const FlagError(),
)

// 5. Lazy load screens (only build when navigated to)
// 6. Isolate for Excel data parsing on startup
// 7. All static data loaded once, stored in provider
// 8. Shimmer loading while API fetches standings

// pubspec.yaml packages for performance:
// shimmer: ^3.0.0 (loading skeletons)
// provider: ^6.1.1 (state management, no rebuilds)
```

---

## 🌐 TIME CONVERSION (UTC → BST)

```dart
// time_converter.dart
class TimeConverter {
  static DateTime utcToBST(String utcString) {
    return DateTime.parse(utcString).add(const Duration(hours: 6));
  }
  
  static String formatBSTDisplay(DateTime bst) {
    final hour = bst.hour;
    final min = bst.minute.toString().padLeft(2, '0');
    if (hour == 0) return 'রাত ১২:$min';
    if (hour < 6)  return 'রাত ${_toBengaliNum(hour)}:$min';
    if (hour < 12) return 'সকাল ${_toBengaliNum(hour)}:$min';
    if (hour == 12) return 'দুপুর ১২:$min';
    if (hour < 18) return 'বিকেল ${_toBengaliNum(hour-12)}:$min';
    return 'রাত ${_toBengaliNum(hour-12)}:$min';
  }
  
  static String formatBSTDate(DateTime bst) {
    const months = ['','জানুয়ারি','ফেব্রুয়ারি','মার্চ','এপ্রিল',
                    'মে','জুন','জুলাই','আগস্ট','সেপ্টেম্বর',
                    'অক্টোবর','নভেম্বর','ডিসেম্বর'];
    return '${_toBengaliNum(bst.day)} ${months[bst.month]} ${_toBengaliNum(bst.year)}';
  }
  
  static String _toBengaliNum(int n) {
    const map = {'0':'০','1':'১','2':'২','3':'৩','4':'৪',
                 '5':'৫','6':'৬','7':'৭','8':'৮','9':'৯'};
    return n.toString().split('').map((c) => map[c]!).join();
  }
}
```

---

## 📦 pubspec.yaml

```yaml
name: worldcup_2026_bd
description: FIFA World Cup 2026 Schedule App for Bangladesh

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # UI & Fonts
  google_fonts: ^6.1.0          # Hind Siliguri
  cached_network_image: ^3.3.1  # Flag & stadium images
  carousel_slider: ^4.2.1       # Home banner
  shimmer: ^3.0.0               # Loading skeleton
  lottie: ^3.0.0                # Splash animation
  
  # State & Storage
  provider: ^6.1.1              # State management
  shared_preferences: ^2.2.2    # Local cache
  
  # Network
  http: ^1.1.0                  # API calls
  connectivity_plus: ^5.0.2     # Check internet
  
  # AdMob
  google_mobile_ads: ^4.0.0     # AdMob integration
  
  # Notifications (Local only, no Firebase)
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2
  
  # Utility
  url_launcher: ^6.2.2          # Play Store, email
  share_plus: ^7.2.1            # Share app
  intl: ^0.19.0                 # Date formatting
  
  # Excel reading (for data import at build time)
  # Note: Excel data gets hardcoded into Dart files
  # Use Python/Excel → Dart converter during development

flutter:
  uses-material-design: true
  fonts:
    - family: HindSiliguri
      fonts:
        - asset: assets/fonts/HindSiliguri-Regular.ttf
        - asset: assets/fonts/HindSiliguri-Bold.ttf
          weight: 700
  assets:
    - assets/images/        # Static images
    - assets/lottie/        # Animations
```

---

## 🔑 PLAY STORE METADATA

```
App Name (Bengali): ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী
App Name (English): FIFA World Cup 2026 Schedule BD
Package Name:       com.worldcup2026.bangladesh
Version:            1.0.0
Min SDK:            21 (Android 5.0 Lollipop)
Target SDK:         34 (Android 14)
Category:           Sports
Content Rating:     Everyone (PEGI 3 / Everyone)

Short Description (Bengali, 80 chars):
ফিফা বিশ্বকাপ ২০২৬ এর সম্পূর্ণ বাংলা গাইড — সময়সূচী, দল, স্টেডিয়াম

Full Description:
ফিফা ওয়ার্ল্ড কাপ ২০২৬ এর সম্পূর্ণ বাংলা গাইড অ্যাপ।
✅ বাংলাদেশ সময়ে সব ১০৪টি ম্যাচের সময়সূচী
✅ ৪৮টি দলের তথ্য ও খেলোয়াড় তালিকা
✅ ১২টি গ্রুপের বিস্তারিত
✅ ১৭টি স্টেডিয়ামের তথ্য
✅ লাইভ পয়েন্ট টেবিল
✅ বিশ্বকাপের ইতিহাস ১৯৩০-২০২২
✅ ম্যাচ রিমাইন্ডার নোটিফিকেশন
আমেরিকা, কানাডা ও মেক্সিকোতে অনুষ্ঠিত ফিফা বিশ্বকাপ ২০২৬ সম্পর্কে
সব তথ্য এখন বাংলায়!

Keywords: fifa 2026, world cup 2026, বিশ্বকাপ, ফুটবল, schedule, bangladesh

Required Assets:
  ✅ App Icon: 512×512 PNG (trophy on maroon #560027 bg)
  ✅ Feature Graphic: 1024×500 PNG
  ✅ Phone Screenshots: min 4 (Home, Schedule, Teams, Stadiums)
  ✅ Privacy Policy URL (required by Google)
```

---

## 🔐 AndroidManifest.xml Permissions

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
```

---

## ✅ BUILD CHECKLIST

### Phase 1 — Project Setup (Antigravity Day 1)
- [ ] Flutter project create করো: `flutter create worldcup_2026_bd`
- [ ] pubspec.yaml আপডেট করো (উপরের packages)
- [ ] Stitch HTML files থেকে Flutter widgets convert করো
- [ ] AppColors, AppTextStyles তৈরি করো
- [ ] NavigationDrawer implement করো (Stitch থেকে)

### Phase 2 — Static Data Integration (Day 2)
- [ ] Excel files পড়ো → Dart data classes তৈরি করো
- [ ] matches_data.dart (104 matches, BST times pre-calculated)
- [ ] teams_data.dart (48 teams, Bengali names, flag codes)
- [ ] players_data.dart (squads from Excel)
- [ ] stadiums_data.dart (17 stadiums)
- [ ] history_data.dart (1930-2022)

### Phase 3 — Screens (Day 3-5)
- [ ] SplashScreen
- [ ] HomeScreen (Stitch থেকে হুবহু)
- [ ] MatchScheduleScreen + tabs
- [ ] GroupsScreen
- [ ] TeamsScreen (Stitch থেকে হুবহু)
- [ ] TeamDetailScreen
- [ ] StadiumsScreen (Stitch থেকে হুবহু)
- [ ] StadiumDetailScreen

### Phase 4 — Live Features (Day 6)
- [ ] football-data.org API integration (Point Table)
- [ ] Local notifications setup
- [ ] Cache system (SharedPreferences)
- [ ] Pull-to-refresh

### Phase 5 — Monetization (Day 7)
- [ ] AdMob SDK init
- [ ] Banner ads (all screens)
- [ ] Native ads (schedule, teams, groups lists)
- [ ] Interstitial (point table entry)
- [ ] Test with test ad IDs

### Phase 6 — Polish & Publish (Day 8)
- [ ] 5-star rating popup
- [ ] App icon (512×512)
- [ ] Feature graphic (1024×500)
- [ ] Screenshots (4-8 minimum)
- [ ] Privacy Policy page/URL
- [ ] `flutter build apk --release`
- [ ] Sign APK (keystore)
- [ ] Play Store upload

---

---

*FIFA World Cup 2026 Bangladesh App — Final Master Prompt v2.0*
*Design: Google Stitch | Data: FIFA Official API + Excel | Build: Flutter + Claude*
*Monetization: Google AdMob | Distribution: Google Play Store*
