import 'package:apt_api/api.dart';
import 'package:http/http.dart';

class ExerciseTypeTimeData {
  final DateTime startDate;
  final DateTime endDate;
  final List<DayOfWeek> selectedWeekdays;
  final int repeatCount;
  final ActivityRepeat repeats;
  final String time;
  final String endTime;

  ExerciseTypeTimeData(this.startDate, this.endDate, this.selectedWeekdays, this.repeatCount, this.repeats, this.time, this.endTime);

  static int calculateMinutesBetween({required String startTime, required String endTime, double? rating}) {
    if (startTime.isEmpty || endTime.isEmpty) return 0;

    try {
      // Parse time strings (HH:MM format)
      final startParts = startTime.split(':');
      final endParts = endTime.split(':');

      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);
      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);

      // Create DateTime objects for today
      final now = DateTime.now();
      final startDateTime = DateTime(now.year, now.month, now.day, startHour, startMinute);
      var endDateTime = DateTime(now.year, now.month, now.day, endHour, endMinute);

      // If end time is before start time, assume it's the next day
      if (endDateTime.isBefore(startDateTime)) {
        endDateTime = endDateTime.add(Duration(days: 1));
      }

      // Calculate difference in minutes
      int toReturn = endDateTime.difference(startDateTime).inMinutes;
      // when rated as intense double the points
      if (rating != null && rating >= 7) {
        // for klimafit acitivity points are used internally, which are double for intense activities
        toReturn *= 2;
      }
      return toReturn;
    } catch (e) {
      print('Error parsing time: $e');
      return 0;
    }
  }
}

MultipartFile fallbackFile = MultipartFile.fromBytes("pictureFile", []);
