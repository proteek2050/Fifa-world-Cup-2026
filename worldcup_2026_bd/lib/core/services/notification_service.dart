import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../data/matches_data.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _channelId = 'worldcup_match_reminders';
  static const _channelName = 'ম্যাচ রিমাইন্ডার';
  static const _channelDesc = 'বিশ্বকাপ ম্যাচ শুরুর ৩০ মিনিট আগে বিজ্ঞপ্তি';

  static Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    _initialized = true;
  }

  static Future<void> scheduleGroupStageReminders() async {
    if (!_initialized) return;
    await _plugin.cancelAll();

    final groupMatches = allMatches.where((m) => m.isGroupStage).toList();
    int id = 0;

    for (final match in groupMatches) {
      final matchTime = _parseBdDateTime(match.bdDate, match.bdTime);
      if (matchTime == null) continue;

      final reminderTime = matchTime.subtract(const Duration(minutes: 30));
      if (reminderTime.isBefore(DateTime.now())) continue;

      try {
        await _plugin.zonedSchedule(
          id++,
          '⚽ ম্যাচ শুরু হতে ৩০ মিনিট বাকি!',
          '${match.team1Bn} বনাম ${match.team2Bn} — ${match.bdTime} BST',
          tz.TZDateTime.from(reminderTime, tz.local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: _channelDesc,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (e) {
        debugPrint('Notification schedule failed for match ${match.matchNumber}: $e');
      }
    }
  }

  static DateTime? _parseBdDateTime(String bdDate, String bdTime) {
    try {
      // bdDate: '12 Jun 2026', bdTime: '01:00 AM'
      final parts = bdDate.split(' ');
      final day = int.parse(parts[0]);
      final month = _monthNum(parts[1]);
      final year = int.parse(parts[2]);

      final timeParts = bdTime.split(' ');
      final hm = timeParts[0].split(':');
      var hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);
      final isPm = timeParts.length > 1 && timeParts[1].toUpperCase() == 'PM';
      if (isPm && hour != 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;

      return DateTime(year, month, day, hour, minute);
    } catch (_) {
      return null;
    }
  }

  static int _monthNum(String mon) {
    const months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12,
    };
    return months[mon] ?? 1;
  }

  static Future<bool> requestPermission() async {
    final granted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return granted ?? false;
  }
}
