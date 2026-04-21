/// Model for a FIFA World Cup 2026 match.
class MatchModel {
  final int matchNumber;
  final String stageEn;
  final String stageBn;
  final String group; // e.g. 'গ্রুপ A' or '' for knockout
  final String team1En;
  final String team2En;
  final String team1Bn;
  final String team2Bn;
  final String utcDate; // e.g. '11 Jun 2026'
  final String utcTime; // e.g. '19:00 UTC'
  final String bdDate;  // e.g. '12 Jun 2026'
  final String bdTime;  // e.g. '01:00 AM'
  final String stadium;
  final String city;

  const MatchModel({
    required this.matchNumber,
    required this.stageEn,
    required this.stageBn,
    required this.group,
    required this.team1En,
    required this.team2En,
    required this.team1Bn,
    required this.team2Bn,
    required this.utcDate,
    required this.utcTime,
    required this.bdDate,
    required this.bdTime,
    required this.stadium,
    required this.city,
  });

  /// Whether this is a knockout match with TBD teams.
  bool get isTBD => team1En.contains('TBD') || team1Bn.contains('নির্ধারিত');

  /// Whether this is a group stage match.
  bool get isGroupStage => stageEn == 'First Stage';
}
