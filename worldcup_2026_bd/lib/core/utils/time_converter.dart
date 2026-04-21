import 'number_to_bengali.dart';
import '../constants/app_strings.dart';

/// Converts UTC time to Bangladesh Standard Time (BST = UTC+6)
/// and formats dates/times with Bengali text.
///
/// All match times in the app are stored as UTC and displayed as BST.
///
/// Usage:
/// ```dart
/// final bst = TimeConverter.utcToBST('2026-06-12T19:00:00Z');
/// TimeConverter.formatBSTDisplay(bst)  → 'রাত ০১:০০'
/// TimeConverter.formatBSTDate(bst)     → '১২ জুন ২০২৬'
/// ```
class TimeConverter {
  TimeConverter._();

  /// Convert a UTC datetime string to BST (UTC+6).
  static DateTime utcToBST(String utcString) {
    return DateTime.parse(utcString).add(const Duration(hours: 6));
  }

  /// Convert a UTC DateTime object to BST.
  static DateTime utcDateTimeToBST(DateTime utc) {
    return utc.add(const Duration(hours: 6));
  }

  /// Format a BST time for display in Bengali.
  /// Returns time period + hour:minute in Bengali numerals.
  ///
  /// Examples:
  ///   00:30 → 'রাত ১২:৩০'
  ///   03:00 → 'রাত ৩:০০'
  ///   09:00 → 'সকাল ৯:০০'
  ///   12:00 → 'দুপুর ১২:০০'
  ///   15:30 → 'বিকেল ৩:৩০'
  ///   18:00 → 'সন্ধ্যা ৬:০০'
  ///   21:00 → 'রাত ৯:০০'
  static String formatBSTDisplay(DateTime bst) {
    final hour = bst.hour;
    final min = BengaliNumber.padded(bst.minute, 2);

    if (hour == 0) {
      return '${AppStrings.night} ১২:$min';
    } else if (hour < 6) {
      return '${AppStrings.night} ${BengaliNumber.fromInt(hour)}:$min';
    } else if (hour < 12) {
      return '${AppStrings.morning} ${BengaliNumber.fromInt(hour)}:$min';
    } else if (hour == 12) {
      return '${AppStrings.noon} ১২:$min';
    } else if (hour < 17) {
      return '${AppStrings.afternoon} ${BengaliNumber.fromInt(hour - 12)}:$min';
    } else if (hour < 19) {
      return '${AppStrings.evening} ${BengaliNumber.fromInt(hour - 12)}:$min';
    } else {
      return '${AppStrings.night} ${BengaliNumber.fromInt(hour - 12)}:$min';
    }
  }

  /// Format a BST date for display in Bengali.
  /// Returns: "DD মাস YYYY" in Bengali numerals.
  ///
  /// Example: '১২ জুন ২০২৬'
  static String formatBSTDate(DateTime bst) {
    final day = BengaliNumber.fromInt(bst.day);
    final month = AppStrings.months[bst.month];
    final year = BengaliNumber.fromInt(bst.year);
    return '$day $month $year';
  }

  /// Format a BST date and time combined.
  /// Returns: "DD মাস YYYY — সময় HH:MM (BST)"
  ///
  /// Example: '১২ জুন ২০২৬ — রাত ০১:০০'
  static String formatBSTFull(DateTime bst) {
    return '${formatBSTDate(bst)} — ${formatBSTDisplay(bst)}';
  }

  /// Format a short date (no year).
  /// Returns: "DD মাস"
  ///
  /// Example: '১২ জুন'
  static String formatShortDate(DateTime bst) {
    final day = BengaliNumber.fromInt(bst.day);
    final month = AppStrings.months[bst.month];
    return '$day $month';
  }

  /// Get "X minutes ago" in Bengali for last-updated display.
  static String minutesAgo(DateTime lastUpdated) {
    final diff = DateTime.now().difference(lastUpdated).inMinutes;
    if (diff < 1) return 'এইমাত্র';
    return '${BengaliNumber.fromInt(diff)} ${AppStrings.minutesAgo}';
  }

  /// Check if a given BST date is today.
  static bool isToday(DateTime bst) {
    final now = DateTime.now();
    return bst.year == now.year &&
        bst.month == now.month &&
        bst.day == now.day;
  }

  /// Format countdown components (days, hours, minutes, seconds).
  /// Returns a map of Bengali strings.
  static Map<String, String> formatCountdown(Duration duration) {
    return {
      'days': BengaliNumber.padded(duration.inDays, 2),
      'hours': BengaliNumber.padded(duration.inHours.remainder(24), 2),
      'minutes': BengaliNumber.padded(duration.inMinutes.remainder(60), 2),
      'seconds': BengaliNumber.padded(duration.inSeconds.remainder(60), 2),
    };
  }
}
