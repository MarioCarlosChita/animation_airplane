
class Travell{
  final String fromTitle;
  final String fromTime;
  final String toTitle;
  final String toTime;
  final String delay;

  final String airCompany ;
  final String  bundleType;


  Travell({
    required this.airCompany,
    required this.bundleType,
    required this.delay,
    required this.fromTitle,
    required this.toTime,
    required this.toTitle ,
    required this.fromTime
  });
}