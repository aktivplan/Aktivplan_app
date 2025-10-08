// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:async';

import 'package:apt_api/api.dart';
import 'package:aptapp/exercises/bloc/exercise_repository.dart';
import 'package:aptapp/exercises/bloc/training_plan_repository.dart';
import 'package:aptapp/exercises/bloc/workout_repository.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;
  final WorkoutRepository workoutRepository;
  final TrainingPlanRepository trainingPlanRepository;

  ExerciseBloc({
    required this.exerciseRepository,
    required this.workoutRepository,
    required this.trainingPlanRepository,
  }) : super(ExerciseInitial()) {
    on<ResetExerciseBlocEvent>((event, emit) async {
      emit(ExerciseInitial());
    });

    on<FetchStrengtheningExercisesEvent>((event, emit) async {
      List<ExerciseOverviewDTO> exercises = await exerciseRepository.getStrengtheningExercise() ?? [];
      List<StrengtheningExercise> strengtheningList = [];
      exercises.forEach((element) {
        strengtheningList.add(element.strengtheningExercise!);
      });
      emit(FetchedStrengtheningExercisesState(exercises: strengtheningList));
    });

    on<FetchIntervalExerciseEvent>((event, emit) async {
      List<ExerciseOverviewDTO> exercises = await exerciseRepository.getExercise(type: ExerciseType.INTERVAL) ?? [];
      List<IntervalExercise> intervalList = [];
      exercises.forEach((element) {
        intervalList.add(element.intervalExercise!);
      });

      emit(FetchedIntervalExerciseState(exercises: intervalList));
    });

    on<FetchEnduranceExercisesEvent>((event, emit) async {
      List<ExerciseOverviewDTO> exercises = await exerciseRepository.getExercise(type: ExerciseType.ENDURANCE) ?? [];
      List<EnduranceExercise> enduranceList = [];
      exercises.forEach((element) {
        enduranceList.add(element.enduranceExercise!);
      });
      emit(FetchedEnduranceExercisesState(exercises: enduranceList));
    });

    on<FetchHypertrophyExerciseEvent>((event, emit) async {
      List<ExerciseOverviewDTO> exercises = await exerciseRepository.getHypertrophyExercise() ?? [];
      List<StrengtheningExercise> strengtheningList = [];
      exercises.forEach((element) {
        strengtheningList.add(element.strengtheningExercise!);
      });
      emit(FetchedHypertrophyExerciseState(exercises: strengtheningList));
    });

    on<FetchOtherExercisesEvent>((event, emit) async {
      List<ExerciseOverviewDTO> exercises = await exerciseRepository.getExercise(type: ExerciseType.OTHER) ?? [];
      emit(FetchedOtherExerciseState(exercises: exercises.map((e) => e.otherExercise!).toList()));
    });

    on<FetchTasksEvent>((event, emit) async {
      List<ExerciseOverviewDTO> tasks = await exerciseRepository.getExercise(type: ExerciseType.TASK) ?? [];
      emit(FetchedTasksState(tasks: tasks.map((e) => e.task!).toList()));
    });

    on<FetchWorkoutExerciseEvent>((event, emit) async {
      List<Workout> workouts = await workoutRepository.fetchWorkouts() ?? [];
      emit(FetchedWorkoutExerciseState(workouts: workouts));
    });

    on<FetchTrainingPlansEvent>((event, emit) async {
      List<TrainingPlanOverviewDTO> trainingPlans = await trainingPlanRepository.fetchTrainingPlans() ?? [];
      emit(FetchedTrainingPlansState(trainingPlans: trainingPlans));
    });

    on<ExerciseTypesHomeEvent>((event, emit) async {
      emit(ExerciseInitial());
    });

    on<ExerciseTypesLoadingEvent>((event, emit) async {
      emit(ExercisesLoadingState());
    });

    // ADD
    on<SaveExerciseEvent>((event, emit) async {
      var exerciseToSave = event.exercise;
      if (exerciseToSave is EnduranceExercisePostDTO) {
        await exerciseRepository.createEndurance(enduranceExercise: event.exercise);
        emit(CreatedEnduranceState());
      } else if (exerciseToSave is IntervalExercisePostDTO) {
        await exerciseRepository.createInterval(intervalExercise: event.exercise);
        emit(CreatedIntervalState());
      } else if (exerciseToSave is StrengtheningExercisePostDTO) {
        await exerciseRepository.createStrengthening(strengtheningExercise: event.exercise);
        if (exerciseToSave.type == ExerciseType.HYPERTROPHY) {
          emit(CreatedHypertrophyState());
        } else {
          emit(CreatedStrengtheningState());
        }
      } else if (exerciseToSave is OtherExercisePostDTO) {
        await exerciseRepository.createOther(otherExercise: event.exercise);
        emit(CreatedOtherState());
      } else if (exerciseToSave is TaskPostDTO) {
        await exerciseRepository.createTask(task: event.exercise);
        emit(CreatedTaskState());
      }
      MatomoTracker.instance
          .trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_CREATE, action: "Created Exercise with Type ${event.type}"),
      );
      this.addTypeEvent(event.type); //fetch the updated events
    });

    // UPDATED
    on<UpdateExerciseEvent>((event, emit) async {
      var exerciseToUpdate = event.exercise;
      if (exerciseToUpdate is EnduranceExercisePostDTO) {
        await exerciseRepository.updateEndurance(id: event.id, enduranceExercise: event.exercise);
        emit(UpdatedEnduranceState());
      } else if (exerciseToUpdate is IntervalExercisePostDTO) {
        await exerciseRepository.updateInterval(id: event.id, intervalExercise: event.exercise);
        emit(UpdatedIntervalState());
      } else if (exerciseToUpdate is StrengtheningExercisePostDTO) {
        await exerciseRepository.updateStrengthening(id: event.id, strengtheningExercise: event.exercise);
        if (exerciseToUpdate.type == ExerciseType.HYPERTROPHY) {
          emit(UpdatedHypertrophyState());
        } else {
          emit(UpdatedStrengtheningState());
        }
      } else if (exerciseToUpdate is OtherExercisePostDTO) {
        await exerciseRepository.updateOther(id: event.id, otherExercise: event.exercise);
        emit(UpdatedOtherState());
      } else if (exerciseToUpdate is TaskPostDTO) {
        await exerciseRepository.updateTask(id: event.id, task: event.exercise);
        emit(UpdatedTaskState());
      }
      MatomoTracker.instance
          .trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_UPDATE, action: "Updated Exercise with Type ${event.type}"),
      );
      this.addTypeEvent(event.type); //fetch the updated events
    });

    on<DeleteExerciseEvent>((event, emit) async {
      await exerciseRepository.deleteExerciseType(id: event.id);
      if (event.type == ExerciseType.ENDURANCE) {
        emit(DeletedEnduranceState());
      } else if (event.type == ExerciseType.INTERVAL) {
        emit(DeletedIntervalState());
      } else if (event.type == ExerciseType.STRENGTHENING) {
        emit(DeletedStrengtheningState());
      } else if (event.type == ExerciseType.HYPERTROPHY) {
        emit(DeletedHypertrophyState());
      } else if (event.type == ExerciseType.OTHER) {
        emit(DeletedOtherState());
      } else if (event.type == ExerciseType.TASK) {
        emit(DeletedTaskState());
      }
      MatomoTracker.instance
          .trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_DELETE, action: "Deleted Exercise with Type ${event.type}"),
      );
      this.addTypeEvent(event.type); //fetch the updated events
    });

    on<SaveWorkoutEvent>((event, emit) async {
      await workoutRepository.addWorkout(workout: event.workout);
      emit(CreatedWorkoutState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_CREATE, action: "Created Workout"),
      );
      this.add(FetchWorkoutExerciseEvent());
    });
    on<UpdateWorkoutEvent>((event, emit) async {
      await workoutRepository.updateWorkout(id: event.id, workout: event.workout);
      emit(UpdatedWorkoutState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_UPDATE, action: "Updated Workout"),
      );
      this.add(FetchWorkoutExerciseEvent());
    });
    on<DeleteWorkoutEvent>((event, emit) async {
      await workoutRepository.deleteWorkout(id: event.id);
      emit(DeletedWorkoutState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_EXERCISE, name: EVENT_NAME_DELETE, action: "Deleted Workout"),
      );
      this.add(FetchWorkoutExerciseEvent());
    });

    on<SaveTrainingPlanEvent>((event, emit) async {
      await trainingPlanRepository.addTrainingPlan(event.trainingPlan);
      emit(CreatedTrainingPlanState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_TRAINING_PLAN, name: EVENT_NAME_CREATE, action: "Created Exercise Plan"),
      );
      this.add(FetchTrainingPlansEvent());
    });
    on<UpdateTrainingPlanEvent>((event, emit) async {
      await trainingPlanRepository.updateTrainingPlan(event.id, event.trainingPlan);
      emit(UpdatedTrainingPlanState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_TRAINING_PLAN, name: EVENT_NAME_UPDATE, action: "Updated Exercise Plan"),
      );
      this.add(FetchTrainingPlansEvent());
    });
    on<DeleteTrainingPlanEvent>((event, emit) async {
      await trainingPlanRepository.deleteTrainingPlan(event.id);
      emit(DeletedTrainingPlanState());
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_TRAINING_PLAN, name: EVENT_NAME_DELETE, action: "Deleted Exercise Plan"),
      );
      this.add(FetchTrainingPlansEvent());
    });
  }

  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    try {} on Exception catch (e) {
      print("ERROR: $e");
      yield ExerciseTypesErrorState();
      yield ExerciseInitial();
    }
  }

  addTypeEvent(ExerciseType type) {
    if (type == ExerciseType.ENDURANCE) {
      add(FetchEnduranceExercisesEvent());
    } else if (type == ExerciseType.INTERVAL) {
      add(FetchIntervalExerciseEvent());
    } else if (type == ExerciseType.STRENGTHENING) {
      add(FetchStrengtheningExercisesEvent());
    } else if (type == ExerciseType.HYPERTROPHY) {
      add(FetchHypertrophyExerciseEvent());
    } else if (type == ExerciseType.OTHER) {
      add(FetchOtherExercisesEvent());
    } else if (type == ExerciseType.TASK) {
      add(FetchTasksEvent());
    } else {
      return; //in create activity when workout chosen
    }
  }
}
