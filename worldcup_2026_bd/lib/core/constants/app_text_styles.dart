import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system based on Stitch DESIGN.md ("The Midnight Pitch / Crimson Theatre").
///
/// Font usage:
/// - **Hind Siliguri**: All Bengali UI text (400, 600, 700)
/// - **Lexend**: Display headlines, scorelines, group letters (imported via GoogleFonts)
/// - **Plus Jakarta Sans**: Body stats, articles (imported via GoogleFonts)
///
/// Rules from DESIGN.md:
/// - Bengali line-height: minimum 1.5 (prevents vowel sign overlap)
/// - Body text color: #f0dee1 — NOT pure white
/// - No pure black (#000000) text
class AppTextStyles {
  AppTextStyles._();

  // ═══════════════════════════════════════════
  //  BENGALI UI TEXT (Hind Siliguri)
  // ═══════════════════════════════════════════

  /// App bar title — 18sp bold white
  static TextStyle appBarTitle = GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.5,
  );

  /// Section title — 20sp bold white (e.g. "ম্যাচ এবং সময়সূচী")
  static TextStyle sectionTitle = GoogleFonts.hindSiliguri(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.5,
  );

  /// Card label — 16sp semibold white (grid card labels like "গ্রুপসমূহ")
  static TextStyle cardLabel = GoogleFonts.hindSiliguri(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.5,
  );

  /// Body text — 14sp regular, bone white (#f0dee1)
  static TextStyle body = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface,
    height: 1.5,
  );

  /// Body text bold
  static TextStyle bodyBold = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
    height: 1.5,
  );

  /// Small label — 12sp, gray
  static TextStyle caption = GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textGray,
    height: 1.5,
  );

  /// Extra small — 11sp bold, dark bg (for badges)
  static TextStyle badge = GoogleFonts.hindSiliguri(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.bgDark,
    height: 1.5,
  );

  /// Drawer nav item — 18sp regular white
  static TextStyle drawerItem = GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    height: 1.5,
  );

  /// Drawer title — 24sp bold white
  static TextStyle drawerTitle = GoogleFonts.hindSiliguri(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.5,
  );

  /// Drawer subtitle — 14sp, light accent color
  static TextStyle drawerSubtitle = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.drawerLight,
    height: 1.5,
  );

  /// Drawer footer label — 12sp, light accent
  static TextStyle drawerFooter = GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.drawerLight,
    height: 1.5,
  );

  /// Teams card name — 16sp bold, dark text (on white cards)
  static TextStyle teamCardName = GoogleFonts.hindSiliguri(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF0F172A), // slate-900
    height: 1.5,
  );

  /// Match card team name — 15sp semibold white
  static TextStyle matchTeamName = GoogleFonts.hindSiliguri(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.5,
  );

  /// Match card date/time — 13sp regular, light text
  static TextStyle matchDateTime = GoogleFonts.hindSiliguri(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  /// Stadium name — 16sp bold cyan
  static TextStyle stadiumName = GoogleFonts.hindSiliguri(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.cyan,
    height: 1.5,
  );

  /// Group header — 18sp bold gold (e.g. "গ্রুপ A")
  static TextStyle groupHeader = GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 1.5,
  );

  /// "আজকের ম্যাচ" section title — 18sp bold gold
  static TextStyle todayMatchTitle = GoogleFonts.hindSiliguri(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 1.5,
  );

  /// Player name — 15sp bold, on-surface
  static TextStyle playerName = GoogleFonts.hindSiliguri(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
    height: 1.5,
  );

  /// Player position — 12sp regular, gray
  static TextStyle playerPosition = GoogleFonts.hindSiliguri(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textGray,
    height: 1.5,
  );

  /// Stadium detail title — 28sp bold white
  static TextStyle stadiumDetailTitle = GoogleFonts.hindSiliguri(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.3,
  );

  // ═══════════════════════════════════════════
  //  DISPLAY / HEADLINES (Lexend)
  // ═══════════════════════════════════════════

  /// Large display — scorelines, hero numbers (Lexend)
  static TextStyle displayLarge = GoogleFonts.lexend(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  /// Headline — group letters, match headers (Lexend)
  static TextStyle headline = GoogleFonts.lexend(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  /// VS text — gold, bold (Lexend)
  static TextStyle vsText = GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.gold,
  );

  // ═══════════════════════════════════════════
  //  BODY / STATS (Plus Jakarta Sans)
  // ═══════════════════════════════════════════

  /// Stats table text
  static TextStyle statsBody = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );

  /// Stats table header
  static TextStyle statsHeader = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textGray,
  );

  /// Info card title (yellow) — stadium detail
  static TextStyle infoCardTitle = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 1.5,
  );

  /// Info card value — white
  static TextStyle infoCardValue = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    height: 1.5,
  );

  // ═══════════════════════════════════════════
  //  TAB STYLES
  // ═══════════════════════════════════════════

  /// Active tab (dark text on gold pill)
  static TextStyle tabActive = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.bgDark,
    height: 1.5,
  );

  /// Inactive tab (white text)
  static TextStyle tabInactive = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    height: 1.5,
  );
}
