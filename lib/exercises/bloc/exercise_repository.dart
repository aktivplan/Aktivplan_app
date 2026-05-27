import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';
import 'package:http/http.dart';

class ExerciseRepository {
  final exerciseApi = new ExerciseControllerApi(apiClient);

  Future<List<ExerciseOverviewDTO>?> getExercise({required ExerciseType type}) async {
    return exerciseApi.getExercises(type);
  }

  Future<List<ExerciseOverviewDTO>?> getHypertrophyExercise() async {
    return exerciseApi.getExercises(ExerciseType.HYPERTROPHY);
  }

  Future<List<ExerciseOverviewDTO>?> getStrengtheningExercise() async {
    return exerciseApi.getExercises(ExerciseType.STRENGTHENING);
  }

  Future<EnduranceExercise?> createEndurance({required EnduranceExercisePostDTO enduranceExercise, MultipartFile? videoFile}) async {
    var createdExercise = await exerciseApi.createEnduranceExercise(enduranceExercise);
    if (videoFile != null) {
      var createdFile = await exerciseApi.uploadExerciseVideoById(createdExercise!.id!, videoFile);
      createdExercise.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdExercise;
  }

  Future<IntervalExercise?> createInterval({required IntervalExercisePostDTO intervalExercise, MultipartFile? videoFile}) async {
    var createdExercise = await exerciseApi.createIntervalExercise(intervalExercise);
    if (videoFile != null) {
      var createdFile = await exerciseApi.uploadExerciseVideoById(createdExercise!.id!, videoFile);
      createdExercise.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdExercise;
  }

  Future<StrengtheningExercise?> createStrengthening({required StrengtheningExercisePostDTO strengtheningExercise, MultipartFile? videoFile}) async {
    var createdExercise;
    if (strengtheningExercise.type == ExerciseType.HYPERTROPHY) {
      createdExercise = await exerciseApi.createHypertrophyExercise(strengtheningExercise);
    } else {
      createdExercise = await exerciseApi.createStrengtheningExercise(strengtheningExercise);
    }
    if (videoFile != null) {
      var createdFile = await exerciseApi.uploadExerciseVideoById(createdExercise!.id!, videoFile);
      createdExercise.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdExercise;
  }

  Future<OtherExercise?> createOther({required OtherExercisePostDTO otherExercise, MultipartFile? videoFile}) async {
    var createdExercise = await exerciseApi.createOtherExercise(otherExercise);
    if (videoFile != null) {
      var createdFile = await exerciseApi.uploadExerciseVideoById(createdExercise!.id!, videoFile);
      createdExercise.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdExercise;
  }

  Future<Task?> createTask({required TaskPostDTO task, MultipartFile? videoFile}) async {
    var createdTask = await exerciseApi.createTask(task);
    if (videoFile != null) {
      var createdFile = await exerciseApi.uploadExerciseVideoById(createdTask!.id!, videoFile);
      createdTask.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdTask;
  }

  Future<EnduranceExercise?> updateEndurance(
      {required String id, required EnduranceExercisePostDTO enduranceExercise, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedExercise = await exerciseApi.updateEnduranceExercise(id, enduranceExercise);
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await exerciseApi.uploadExerciseVideoById(updatedExercise!.id!, videoFile);
        updatedExercise.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await exerciseApi.deleteExerciseVideoById(id);
        updatedExercise!.videoFileKey = "";
      }
    }
    return updatedExercise;
  }

  Future<IntervalExercise?> updateInterval(
      {required String id, required IntervalExercisePostDTO intervalExercise, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedExercise = await exerciseApi.updateIntervalExercise(id, intervalExercise);
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await exerciseApi.uploadExerciseVideoById(updatedExercise!.id!, videoFile);
        updatedExercise.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await exerciseApi.deleteExerciseVideoById(id);
        updatedExercise!.videoFileKey = "";
      }
    }
    return updatedExercise;
  }

  Future<StrengtheningExercise?> updateStrengthening(
      {required String id, required StrengtheningExercisePostDTO strengtheningExercise, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedExercise;
    if (strengtheningExercise.type == ExerciseType.HYPERTROPHY) {
      updatedExercise = await exerciseApi.updateHypertrophyExercise(id, strengtheningExercise);
    } else {
      updatedExercise = await exerciseApi.updateStrengtheningExercise(id, strengtheningExercise);
    }
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await exerciseApi.uploadExerciseVideoById(updatedExercise!.id!, videoFile);
        updatedExercise.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await exerciseApi.deleteExerciseVideoById(id);
        updatedExercise!.videoFileKey = "";
      }
    }
    return updatedExercise;
  }

  Future<OtherExercise?> updateOther(
      {required String id, required OtherExercisePostDTO otherExercise, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedExercise = await exerciseApi.updateOtherExercise(id, otherExercise);
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await exerciseApi.uploadExerciseVideoById(updatedExercise!.id!, videoFile);
        updatedExercise.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await exerciseApi.deleteExerciseVideoById(id);
        updatedExercise!.videoFileKey = "";
      }
    }
    return updatedExercise;
  }

  Future<Task?> updateTask({required String id, required TaskPostDTO task, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedTask = await exerciseApi.updateTask(id, task);
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await exerciseApi.uploadExerciseVideoById(updatedTask!.id!, videoFile);
        updatedTask.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await exerciseApi.deleteExerciseVideoById(id);
        updatedTask!.videoFileKey = "";
      }
    }
    return updatedTask;
  }

  Future deleteExerciseType({required String id}) async {
    await exerciseApi.deleteExercise(id);
  }
}
