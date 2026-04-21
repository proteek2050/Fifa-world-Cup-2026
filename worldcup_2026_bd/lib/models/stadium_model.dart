/// Model for a World Cup 2026 stadium/venue.
class StadiumModel {
  final int id;
  final String nameEn;
  final String nameBn;
  final String city;
  final String country;
  final int capacity;
  final int yearBuilt;
  final String surfaceType;
  final String timezone;
  final String bdtOffset;
  final String totalMatches;
  final String description;

  const StadiumModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.city,
    required this.country,
    required this.capacity,
    required this.yearBuilt,
    required this.surfaceType,
    required this.timezone,
    required this.bdtOffset,
    required this.totalMatches,
    required this.description,
  });
}
