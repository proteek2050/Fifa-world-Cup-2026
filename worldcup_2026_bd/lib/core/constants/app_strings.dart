/// All Bengali (বাংলা) strings used throughout the app.
/// Centralized here for consistency and easy maintenance.
class AppStrings {
  AppStrings._();

  // ─── App Identity ───
  static const String appName = 'ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী';
  static const String appNameShort = 'বিশ্বকাপ ২০২৬';
  static const String appBarTitle = 'বিশ্বকাপ ফুটবল সময়সূচী ২০২৬';
  static const String appSubtitle = 'অফিসিয়াল অ্যাপ';

  // ─── Home Screen Grid Labels ───
  static const String matchAndSchedule = 'ম্যাচ এবং সময়সূচী';
  static const String groups = 'গ্রুপসমূহ';
  static const String teams = 'দলসমূহ';
  static const String stadiums = 'স্টেডিয়াম';
  static const String visitingPlaces = 'ভ্রমণ স্থান';
  static const String players = 'খেলোয়াড়';
  static const String highlights = 'হাইলাইটস';
  static const String pointTable = 'পয়েন্ট টেবিল';
  static const String history = 'ইতিহাস';

  // ─── Section Titles ───
  static const String todaysMatch = 'আজকের ম্যাচ';
  static const String noMatchToday = 'আজ কোনো ম্যাচ নেই 😔';
  static const String nextMatchIn = 'পরবর্তী ম্যাচ শুরু হতে আর';
  static const String schedule = 'সময়সূচী';

  // ─── Schedule Tabs ───
  static const String groupStage = 'গ্রুপ স্টেজ';
  static const String roundOf32 = 'রাউন্ড অব ৩২';
  static const String roundOf16 = 'রাউন্ড অব ১৬';
  static const String quarterFinal = 'কোয়ার্টার ফাইনাল';
  static const String semiFinal = 'সেমি ফাইনাল';
  static const String thirdPlace = 'তৃতীয় স্থান';
  static const String finalMatch = 'ফাইনাল';

  // ─── Match Card ───
  static const String vs = 'VS';
  static const String matchNo = 'ম্যাচ';
  static const String group = 'গ্রুপ';
  static const String tbd = 'নির্ধারিত হবে';

  // ─── Teams / Players ───
  static const String allTeams = 'সকল দল';
  static const String worldCupTeam2026 = 'বিশ্বকাপ দল ২০২৬';
  static const String all = 'সকলে';
  static const String goalkeeper = 'গোলরক্ষক';
  static const String defender = 'ডিফেন্ডার';
  static const String midfielder = 'মিডফিল্ডার';
  static const String forward = 'ফরোয়ার্ড';
  static const String captain = 'ক্যাপ্টেন';

  // ─── Stadium Detail ───
  static const String location = 'অবস্থান';
  static const String capacity = 'ধারণক্ষমতা';
  static const String seats = 'আসন';
  static const String inaugurated = 'উদ্বোধন';
  static const String fixtures = 'ফিক্সচার';
  static const String aboutStadium = 'স্টেডিয়াম সম্পর্কে';

  // ─── Point Table ───
  static const String pointTableTitle = 'পয়েন্ট টেবিল';
  static const String team = 'দল';
  static const String played = 'খে';     // খেলা (Matches Played)
  static const String won = 'জ';         // জয় (Won)
  static const String drawn = 'ড';       // ড্র (Draw)
  static const String lost = 'হ';        // হার (Lost)
  static const String goalsFor = 'গো+';  // গোল ফর
  static const String goalsAgainst = 'গো-';  // গোল অ্যাগেইনস্ট
  static const String goalDiff = 'গোব';  // গোল ব্যবধান
  static const String points = 'পয়';    // পয়েন্ট
  static const String lastUpdated = 'শেষ আপডেট';
  static const String minutesAgo = 'মিনিট আগে';
  static const String offlineMode = 'অফলাইন মোড';

  // ─── History ───
  static const String historyTitle = 'কে কতবার বিজয়ী';
  static const String winners = 'উইনার্স';
  static const String runnersUp = 'রানার্স-আপ';
  static const String times = 'বার';
  static const String fullHistory = 'সম্পূর্ণ ইতিহাস';
  static const String year = 'বছর';
  static const String host = 'আয়োজক';
  static const String champion = 'চ্যাম্পিয়ন';
  static const String runnerUp = 'রানার-আপ';
  static const String score = 'স্কোর';

  // ─── Navigation Drawer ───
  static const String rateFiveStar = '৫ স্টার রেট দিন';
  static const String shareApp = 'অ্যাপটি শেয়ার করুন';
  static const String bugReport = 'বাগ রিপোর্ট করুন';
  static const String feedback = 'মতামত ও পরামর্শ';
  static const String settings = 'সেটিংস';
  static const String logout = 'লগ আউট';
  static const String about = 'সম্পর্কে';

  // ─── Rating Dialog ───
  static const String ratingQuestion = 'আপনি কি এই অ্যাপটি উপভোগ করছেন?';
  static const String rateNow = 'রেটিং দিন';
  static const String later = 'পরে';
  static const String noThanks = 'না, ধন্যবাদ';

  // ─── Notifications ───
  static const String matchReminder = '⚽ ম্যাচ শুরু হতে ৩০ মিনিট বাকি!';

  // ─── Time Periods (BST) ───
  static const String night = 'রাত';
  static const String morning = 'সকাল';
  static const String noon = 'দুপুর';
  static const String afternoon = 'বিকেল';
  static const String evening = 'সন্ধ্যা';

  // ─── Countdown ───
  static const String days = 'দিন';
  static const String hours = 'ঘণ্টা';
  static const String minutes = 'মিনিট';
  static const String seconds = 'সেকেন্ড';

  // ─── Search ───
  static const String searchHint = 'দলের নাম, স্টেডিয়াম, তারিখ দিয়ে খুঁজুন...';

  // ─── Host Countries ───
  static const String hostCountries = '🇺🇸 আমেরিকা • 🇨🇦 কানাডা • 🇲🇽 মেক্সিকো';

  // ─── Bengali Month Names ───
  static const List<String> months = [
    '',          // 0 - unused
    'জানুয়ারি',  // 1
    'ফেব্রুয়ারি', // 2
    'মার্চ',      // 3
    'এপ্রিল',    // 4
    'মে',        // 5
    'জুন',       // 6
    'জুলাই',     // 7
    'আগস্ট',     // 8
    'সেপ্টেম্বর',  // 9
    'অক্টোবর',   // 10
    'নভেম্বর',    // 11
    'ডিসেম্বর',   // 12
  ];

  // ─── Group Names ───
  static const List<String> groupNames = [
    'গ্রুপ A', 'গ্রুপ B', 'গ্রুপ C', 'গ্রুপ D',
    'গ্রুপ E', 'গ্রুপ F', 'গ্রুপ G', 'গ্রুপ H',
    'গ্রুপ I', 'গ্রুপ J', 'গ্রুপ K', 'গ্রুপ L',
  ];
}
