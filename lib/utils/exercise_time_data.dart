// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
