import 'dart:ui';

/// All color tokens extracted from Stitch designs (Home Screen, Teams, Navigation Drawer).
/// DO NOT modify these — they are matched pixel-perfect to the Stitch HTML prototypes.
class AppColors {
  AppColors._();

  // ─── Background Gradients (Home Screen) ───
  /// Home screen gradient top: deep maroon
  static const Color bgGradientTop = Color(0xFF4A041C);

  /// Home screen gradient bottom: darkest maroon
  static const Color bgGradientBottom = Color(0xFF2D0211);

  // ─── Primary Backgrounds ───
  /// Main background (darkest maroon) — used for scaffold bg
  static const Color bgDark = Color(0xFF560027);

  /// App bar, drawer background, card headers
  static const Color bgMedium = Color(0xFF880E4F);

  /// Match cards, nav grid card backgrounds
  static const Color bgCard = Color(0xFF9C1A55);

  /// Status bar simulation background
  static const Color statusBar = Color(0xFF8A0636);

  /// Home screen card background (hero + grid)
  static const Color homeCard = Color(0xFFB00B46);

  // ─── Accent Colors ───
  /// Buttons, active tabs, active pill
  static const Color pink = Color(0xFFC2185B);

  /// Card label bars (Home grid cards)
  static const Color pinkLight = Color(0xFFBC477B);

  /// Highlights, VS text, badges, gold accents
  static const Color gold = Color(0xFFFFD700);

  /// Stadium names, info labels, city names
  static const Color cyan = Color(0xFF00BCD4);

  // ─── Navigation Drawer ───
  /// Drawer main background
  static const Color drawerBg = Color(0xFF880E4F);

  /// Drawer darker variant
  static const Color drawerDark = Color(0xFF560027);

  /// Drawer light accent (hover states, subtitle text)
  static const Color drawerLight = Color(0xFFBC477B);

  // ─── Teams Screen (Dark Mode Material Tokens) ───
  /// Teams screen base background
  static const Color background = Color(0xFF1A1113);

  /// Section backgrounds
  static const Color surfaceContainerLow = Color(0xFF22191B);

  /// Card body
  static const Color surfaceContainer = Color(0xFF271D1F);

  /// Primary cards
  static const Color surfaceContainerHigh = Color(0xFF31272A);

  /// Card headers, floating elements
  static const Color surfaceContainerHighest = Color(0xFF3D3234);

  /// Floating elements
  static const Color surfaceBright = Color(0xFF413639);

  /// Hero gradients
  static const Color primaryContainer = Color(0xFF800021);

  /// Primary accent (buttons, icons, back arrow on Teams screen)
  static const Color primary = Color(0xFFFFB3B5);

  /// Text on primary buttons
  static const Color onPrimary = Color(0xFF680019);

  /// Body text on dark backgrounds (warm bone white — NOT pure white)
  static const Color onSurface = Color(0xFFF0DEE1);

  /// Secondary text
  static const Color onSurfaceVariant = Color(0xFFE0BFBF);

  /// Ghost borders (max 15% opacity)
  static const Color outlineVariant = Color(0xFF584141);

  /// "Live" chip
  static const Color tertiaryContainer = Color(0xFFC9A900);

  /// Unselected filter chips
  static const Color secondaryContainer = Color(0xFF622599);

  /// Selected filter chips
  static const Color secondary = Color(0xFFDDB7FF);

  /// Small captions subtle glow
  static const Color primaryFixedDim = Color(0xFFFFB3B5);

  // ─── Text Colors ───
  static const Color white = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFE0E0E0);
  static const Color textGray = Color(0xFFBDBDBD);

  // ─── Card Colors (Teams list, groups) ───
  /// Teams list card background
  static const Color cardWhite = Color(0xFFFFFFFF);

  /// Card borders
  static const Color cardBorder = Color(0xFFE0E0E0);

  // ─── Info Cards (Stadium Detail) ───
  /// Info card background
  static const Color infoBg = Color(0xFF7B1040);

  /// Icon background (brownish)
  static const Color infoIcon = Color(0xFF8D4E35);

  // ─── History Screen ───
  /// History screen app bar
  static const Color historyBlue = Color(0xFF1565C0);

  // ─── Misc ───
  /// Divider color for drawer sections
  static const Color divider = Color(0xFF9C2060);

  /// Error/red
  static const Color error = Color(0xFFFFB4AB);

  /// Transparent overlay
  static const Color overlayDark = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x33000000); // 20% black
}
