import 'package:flutter/material.dart';
import '../../screens/schedule/schedule_screen.dart';
import '../../screens/groups/groups_screen.dart';
import '../../screens/teams/teams_screen.dart';
import '../../screens/stadiums/stadiums_screen.dart';
import '../../screens/point_table/point_table_screen.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/players/players_screen.dart';
import '../../screens/highlights/highlights_screen.dart';
import '../../screens/about/about_screen.dart';

/// Handles drawer navigation from non-home screens.
/// Replaces the current route with the target screen.
class DrawerNavigator {
  static void navigate(BuildContext context, String route) {
    final screen = _screenFor(route);
    if (screen == null) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static Widget? _screenFor(String route) {
    switch (route) {
      case 'schedule':
        return const ScheduleScreen();
      case 'groups':
        return const GroupsScreen();
      case 'teams':
        return const TeamsScreen();
      case 'stadiums':
        return const StadiumsScreen();
      case 'pointTable':
        return const PointTableScreen();
      case 'history':
        return const HistoryScreen();
      case 'players':
        return const PlayersScreen();
      case 'highlights':
        return const HighlightsScreen();
      case 'settings':
        return const AboutScreen();
      default:
        return null;
    }
  }
}
