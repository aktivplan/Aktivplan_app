import 'package:apt_api/api.dart';

class TimeData {
  final DateTime start;
  final DateTime end;
  final ActiveMinutesType timeframe;

  TimeData({required this.start, required this.end, required this.timeframe});
}
