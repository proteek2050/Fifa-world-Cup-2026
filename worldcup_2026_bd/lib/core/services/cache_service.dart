import 'package:shared_preferences/shared_preferences.dart';

/// Simple key-value cache with TTL, backed by SharedPreferences.
class CacheService {
  static const String _standingsKey = 'standings_cache';
  static const String _standingsTimestampKey = 'standings_cache_ts';
  static const Duration _ttl = Duration(minutes: 5);

  static Future<void> saveStandings(String jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_standingsKey, jsonData);
    await prefs.setInt(
      _standingsTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  static Future<String?> loadStandings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_standingsKey);
  }

  static Future<bool> isStandingsFresh() async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(_standingsTimestampKey);
    if (ts == null) return false;
    final savedAt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(savedAt) < _ttl;
  }

  static Future<DateTime?> standingsCachedAt() async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(_standingsTimestampKey);
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }

  static Future<void> clearStandings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_standingsKey);
    await prefs.remove(_standingsTimestampKey);
  }
}
