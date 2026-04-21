/// Model for a FIFA World Cup 2026 team.
class TeamModel {
  final String nameEn;
  final String nameBn;
  final String group;
  final String confederation;
  final String flagEmoji;

  const TeamModel({
    required this.nameEn,
    required this.nameBn,
    required this.group,
    required this.confederation,
    required this.flagEmoji,
  });
}
