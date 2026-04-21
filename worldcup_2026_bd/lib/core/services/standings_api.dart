import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/groups_data.dart';
import '../../data/teams_data.dart';
import '../../models/standing_model.dart';
import 'cache_service.dart';

class StandingsApi {
  static const String _baseUrl =
      'https://api.football-data.org/v4/competitions/WC/standings';
  static const String _apiKey = '4567397ae55147ce89a7a5f1d835e184';

  /// Returns standings for all 12 groups.
  /// Uses 5-minute cache. Falls back to pre-tournament zeros if API fails.
  static Future<GroupStandings> fetchStandings({bool forceRefresh = false}) async {
    if (!forceRefresh && await CacheService.isStandingsFresh()) {
      return _loadFromCache();
    }

    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'X-Auth-Token': _apiKey},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        await CacheService.saveStandings(response.body);
        return _parseApiResponse(response.body, isFromCache: false);
      } else {
        return _loadFromCacheOrFallback();
      }
    } catch (_) {
      return _loadFromCacheOrFallback();
    }
  }

  static Future<GroupStandings> _loadFromCache() async {
    final json = await CacheService.loadStandings();
    if (json == null) return _buildFallback(isFromCache: false);
    final cachedAt = await CacheService.standingsCachedAt() ?? DateTime.now();
    return _parseApiResponse(json, isFromCache: true, fetchedAt: cachedAt);
  }

  static Future<GroupStandings> _loadFromCacheOrFallback() async {
    final json = await CacheService.loadStandings();
    if (json == null) return _buildFallback(isFromCache: false);
    final cachedAt = await CacheService.standingsCachedAt() ?? DateTime.now();
    return _parseApiResponse(json, isFromCache: true, fetchedAt: cachedAt);
  }

  static GroupStandings _parseApiResponse(
    String body, {
    bool isFromCache = false,
    DateTime? fetchedAt,
  }) {
    try {
      final data = jsonDecode(body) as Map<String, dynamic>;
      final standingsList = data['standings'] as List<dynamic>? ?? [];

      final Map<String, List<StandingModel>> result = {};

      for (final groupData in standingsList) {
        final groupRaw = groupData['group'] as String? ?? '';
        // e.g. "GROUP_A" → "A"
        final letter = groupRaw.replaceFirst('GROUP_', '');
        if (letter.isEmpty || !allGroupLetters.contains(letter)) continue;

        final table = groupData['table'] as List<dynamic>? ?? [];
        final rows = <StandingModel>[];

        for (final row in table) {
          final teamName = (row['team'] as Map<String, dynamic>)['name'] as String? ?? '';
          final match = _findTeam(teamName);
          rows.add(StandingModel.fromApiJson(
            row as Map<String, dynamic>,
            match?.nameBn ?? teamName,
            match?.flagEmoji ?? '🏴',
          ));
        }
        result[letter] = rows;
      }

      // Fill in any missing groups with zeros
      for (final letter in allGroupLetters) {
        if (!result.containsKey(letter)) {
          result[letter] = _buildGroupRows(letter);
        }
      }

      return GroupStandings(
        groups: result,
        fetchedAt: fetchedAt ?? DateTime.now(),
        isFromCache: isFromCache,
      );
    } catch (_) {
      return _buildFallback(isFromCache: isFromCache);
    }
  }

  static GroupStandings _buildFallback({required bool isFromCache}) {
    final Map<String, List<StandingModel>> result = {};
    for (final letter in allGroupLetters) {
      result[letter] = _buildGroupRows(letter);
    }
    return GroupStandings(
      groups: result,
      fetchedAt: DateTime.now(),
      isFromCache: isFromCache,
    );
  }

  static List<StandingModel> _buildGroupRows(String groupLetter) {
    final teams = getTeamsForGroup(groupLetter);
    return List.generate(teams.length, (i) {
      final t = teams[i];
      return StandingModel(
        position: i + 1,
        teamNameEn: t.nameEn,
        teamNameBn: t.nameBn,
        flagEmoji: t.flagEmoji,
        played: 0,
        won: 0,
        drawn: 0,
        lost: 0,
        goalsFor: 0,
        goalsAgainst: 0,
        goalDifference: 0,
        points: 0,
      );
    });
  }

  static _TeamLookup? _findTeam(String apiName) {
    final lower = apiName.toLowerCase();
    for (final t in allTeams) {
      if (t.nameEn.toLowerCase() == lower ||
          lower.contains(t.nameEn.toLowerCase()) ||
          t.nameEn.toLowerCase().contains(lower)) {
        return _TeamLookup(t.nameBn, t.flagEmoji);
      }
    }
    return null;
  }
}

class _TeamLookup {
  final String nameBn;
  final String flagEmoji;
  _TeamLookup(this.nameBn, this.flagEmoji);
}
