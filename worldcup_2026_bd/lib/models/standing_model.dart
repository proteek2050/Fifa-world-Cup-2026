/// Represents one team's standing row in a group table.
class StandingModel {
  final int position;
  final String teamNameEn;
  final String teamNameBn;
  final String flagEmoji;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;

  const StandingModel({
    required this.position,
    required this.teamNameEn,
    required this.teamNameBn,
    required this.flagEmoji,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
  });

  factory StandingModel.fromApiJson(Map<String, dynamic> json, String teamNameBn, String flagEmoji) {
    final team = json['team'] as Map<String, dynamic>;
    return StandingModel(
      position: json['position'] as int,
      teamNameEn: team['name'] as String? ?? '',
      teamNameBn: teamNameBn,
      flagEmoji: flagEmoji,
      played: json['playedGames'] as int? ?? 0,
      won: json['won'] as int? ?? 0,
      drawn: json['draw'] as int? ?? 0,
      lost: json['lost'] as int? ?? 0,
      goalsFor: json['goalsFor'] as int? ?? 0,
      goalsAgainst: json['goalsAgainst'] as int? ?? 0,
      goalDifference: json['goalDifference'] as int? ?? 0,
      points: json['points'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'position': position,
    'teamNameEn': teamNameEn,
    'teamNameBn': teamNameBn,
    'flagEmoji': flagEmoji,
    'played': played,
    'won': won,
    'drawn': drawn,
    'lost': lost,
    'goalsFor': goalsFor,
    'goalsAgainst': goalsAgainst,
    'goalDifference': goalDifference,
    'points': points,
  };

  factory StandingModel.fromCacheJson(Map<String, dynamic> json) {
    return StandingModel(
      position: json['position'] as int,
      teamNameEn: json['teamNameEn'] as String,
      teamNameBn: json['teamNameBn'] as String,
      flagEmoji: json['flagEmoji'] as String,
      played: json['played'] as int,
      won: json['won'] as int,
      drawn: json['drawn'] as int,
      lost: json['lost'] as int,
      goalsFor: json['goalsFor'] as int,
      goalsAgainst: json['goalsAgainst'] as int,
      goalDifference: json['goalDifference'] as int,
      points: json['points'] as int,
    );
  }
}

/// Holds standings for all 12 groups.
class GroupStandings {
  final Map<String, List<StandingModel>> groups;
  final DateTime fetchedAt;
  final bool isFromCache;

  const GroupStandings({
    required this.groups,
    required this.fetchedAt,
    this.isFromCache = false,
  });
}
