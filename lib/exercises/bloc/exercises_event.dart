// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'exercises_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchStrengtheningExercisesEvent extends ExerciseEvent {
  FetchStrengtheningExercisesEvent();

  @override
  List<Object> get props => [];
}

class FetchIntervalExerciseEvent extends ExerciseEvent {
  FetchIntervalExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchEnduranceExercisesEvent extends ExerciseEvent {
  FetchEnduranceExercisesEvent();

  @override
  List<Object> get props => [];
}

class FetchHypertrophyExerciseEvent extends ExerciseEvent {
  FetchHypertrophyExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchOtherExercisesEvent extends ExerciseEvent {
  FetchOtherExercisesEvent();

  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends ExerciseEvent {
  FetchTasksEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkoutExerciseEvent extends ExerciseEvent {
  FetchWorkoutExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchTrainingPlansEvent extends ExerciseEvent {
  FetchTrainingPlansEvent();

  @override
  List<Object> get props => [];
}

class ExerciseTypesErrorEvent extends ExerciseEvent {
  ExerciseTypesErrorEvent();

  @override
  List<Object> get props => [];
}

class ExerciseTypesLoadingEvent extends ExerciseEvent {
  ExerciseTypesLoadingEvent();

  @override
  List<Object> get props => [];
}

class ExerciseTypesHomeEvent extends ExerciseEvent {
  ExerciseTypesHomeEvent();

  @override
  List<Object> get props => [];
}

class SaveExerciseEvent extends ExerciseEvent {
  final exercise;
  final ExerciseType type;

  SaveExerciseEvent({
    required this.type,
    required this.exercise,
  });

  @override
  List<Object> get props => [type, exercise];
}

class UpdateExerciseEvent extends ExerciseEvent {
  final exercise;
  final String id;
  final ExerciseType type;
  UpdateExerciseEvent({
    required this.id,
    required this.type,
    required this.exercise,
  });

  @override
  List<Object> get props => [exercise];
}

class DeleteExerciseEvent extends ExerciseEvent {
  final ExerciseType type;
  final String id;
  DeleteExerciseEvent({required this.type, required this.id});

  @override
  List<Object> get props => [type, id];
}

class SaveWorkoutEvent extends ExerciseEvent {
  final WorkoutPostDTO workout;
  SaveWorkoutEvent({required this.workout});

  @override
  List<Object> get props => [workout];
}

class UpdateWorkoutEvent extends ExerciseEvent {
  final String id;
  final WorkoutPostDTO workout;
  UpdateWorkoutEvent({required this.id, required this.workout});

  @override
  List<Object> get props => [this.id, workout];
}

class DeleteWorkoutEvent extends ExerciseEvent {
  final String id;
  DeleteWorkoutEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveTrainingPlanEvent extends ExerciseEvent {
  final TrainingPlanPostDTO trainingPlan;
  SaveTrainingPlanEvent(this.trainingPlan);

  @override
  List<Object> get props => [trainingPlan];
}

class UpdateTrainingPlanEvent extends ExerciseEvent {
  final String id;
  final TrainingPlanPostDTO trainingPlan;
  UpdateTrainingPlanEvent(this.id, this.trainingPlan);

  @override
  List<Object> get props => [id, trainingPlan];
}

class DeleteTrainingPlanEvent extends ExerciseEvent {
  final String id;
  DeleteTrainingPlanEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ResetExerciseBlocEvent extends ExerciseEvent {
  ResetExerciseBlocEvent();

  @override
  List<Object> get props => [];
}
