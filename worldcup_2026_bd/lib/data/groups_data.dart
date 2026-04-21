import '../models/team_model.dart';
import 'teams_data.dart';

/// Groups A through L, each with 4 teams.
/// Maps group letter to list of team indices in allTeams.
final Map<String, List<String>> groupTeams = {
  'A': ['Czechia', 'Korea Republic', 'Mexico', 'South Africa'],
  'B': ['Bosnia-Herzegovina', 'Canada', 'Qatar', 'Switzerland'],
  'C': ['Brazil', 'Haiti', 'Morocco', 'Scotland'],
  'D': ['Australia', 'Paraguay', 'Türkiye', 'USA'],
  'E': ['Curaçao', 'Côte d\'Ivoire', 'Ecuador', 'Germany'],
  'F': ['Japan', 'Netherlands', 'Sweden', 'Tunisia'],
  'G': ['Belgium', 'Egypt', 'IR Iran', 'New Zealand'],
  'H': ['Cabo Verde', 'Saudi Arabia', 'Spain', 'Uruguay'],
  'I': ['France', 'Iraq', 'Norway', 'Senegal'],
  'J': ['Algeria', 'Argentina', 'Austria', 'Jordan'],
  'K': ['Colombia', 'Congo DR', 'Portugal', 'Uzbekistan'],
  'L': ['Croatia', 'England', 'Ghana', 'Panama'],
};

/// Get teams for a given group letter.
List<TeamModel> getTeamsForGroup(String groupLetter) {
  final names = groupTeams[groupLetter] ?? [];
  return allTeams.where((t) => names.contains(t.nameEn)).toList();
}

/// All group letters in order.
final List<String> allGroupLetters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
