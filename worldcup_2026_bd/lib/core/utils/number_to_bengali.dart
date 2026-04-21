/// Converts English/Arabic numerals (0-9) to Bengali numerals (০-৯).
///
/// Usage:
/// ```dart
/// toBengaliNum(2026)    → '২০২৬'
/// toBengaliNum(104)     → '১০৪'
/// toBengaliDigits('12') → '১২'
/// ```
class BengaliNumber {
  BengaliNumber._();

  static const Map<String, String> _digitMap = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  /// Converts an integer to a Bengali numeral string.
  /// Example: 2026 → '২০২৬'
  static String fromInt(int number) {
    return number.toString().split('').map((c) => _digitMap[c] ?? c).join();
  }

  /// Converts a numeric string to Bengali digits.
  /// Example: '12:30' → '১২:৩০'
  static String fromString(String text) {
    return text.split('').map((c) => _digitMap[c] ?? c).join();
  }

  /// Converts a double to Bengali with specified decimal places.
  /// Example: 87523.0 → '৮৭,৫২৩'
  static String withComma(int number) {
    // Format with commas (Indian numbering: last 3, then groups of 2)
    final str = number.toString();
    if (str.length <= 3) return fromInt(number);

    final lastThree = str.substring(str.length - 3);
    final remaining = str.substring(0, str.length - 3);

    // Add commas every 2 digits for Indian numbering system
    final buffer = StringBuffer();
    for (int i = 0; i < remaining.length; i++) {
      if (i > 0 && (remaining.length - i) % 2 == 0) {
        buffer.write(',');
      }
      buffer.write(remaining[i]);
    }
    buffer.write(',');
    buffer.write(lastThree);

    return fromString(buffer.toString());
  }

  /// Pads a number with leading zeros to specified width, then converts.
  /// Example: padded(5, 2) → '০৫'
  static String padded(int number, int width) {
    return fromString(number.toString().padLeft(width, '0'));
  }
}
