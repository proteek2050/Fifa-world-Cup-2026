/// Model for a World Cup historical result (1930-2022).
class HistoryModel {
  final int year;
  final String host;
  final String champion;
  final String runnerUp;
  final String thirdPlace;
  final String score;

  const HistoryModel({
    required this.year,
    required this.host,
    required this.champion,
    required this.runnerUp,
    required this.thirdPlace,
    required this.score,
  });
}
