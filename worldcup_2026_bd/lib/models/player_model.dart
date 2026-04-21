/// Model for a player in a World Cup squad.
class PlayerModel {
  final String name;
  final String nameBn;
  final String position;
  final String positionBn;
  final String teamEn;
  final String teamBn;
  final int jerseyNumber;
  final String club;

  const PlayerModel({
    required this.name,
    required this.nameBn,
    required this.position,
    required this.positionBn,
    required this.teamEn,
    required this.teamBn,
    required this.jerseyNumber,
    required this.club,
  });
}
