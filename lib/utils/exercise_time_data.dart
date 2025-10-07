import 'package:apt_api/api.dart';
import 'package:http/http.dart';

class ExerciseTypeTimeData {
  final DateTime startDate;
  final DateTime endDate;
  final List<DayOfWeek> selectedWeekdays;
  final int repeatCount;
  final ActivityRepeat repeats;
  final String time;

  ExerciseTypeTimeData(this.startDate, this.endDate, this.selectedWeekdays, this.repeatCount, this.repeats, this.time);
}

MultipartFile fallbackFile = MultipartFile.fromBytes("pictureFile", []);
