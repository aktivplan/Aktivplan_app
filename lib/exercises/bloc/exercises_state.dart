part of 'exercises_bloc.dart';

abstract class ExerciseState extends Equatable {
  ExerciseState();
  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class FetchedStrengtheningExercisesState extends ExerciseState {
  final List<StrengtheningExercise> exercises;
  FetchedStrengtheningExercisesState({required this.exercises});
  @override
  List<Object> get props => [exercises];
}

class FetchedIntervalExerciseState extends ExerciseState {
  final List<IntervalExercise> exercises;

  FetchedIntervalExerciseState({required this.exercises});

  @override
  List<Object> get props => [exercises];
}

class FetchedEnduranceExercisesState extends ExerciseState {
  final List<EnduranceExercise> exercises;
  FetchedEnduranceExercisesState({required this.exercises});
  @override
  List<Object> get props => [exercises];
}

class FetchedHypertrophyExerciseState extends ExerciseState {
  final List<StrengtheningExercise> exercises;
  FetchedHypertrophyExerciseState({required this.exercises});
  @override
  List<Object> get props => [exercises];
}

class FetchedOtherExerciseState extends ExerciseState {
  final List<OtherExercise> exercises;
  FetchedOtherExerciseState({required this.exercises});
  @override
  List<Object> get props => [exercises];
}

class FetchedTasksState extends ExerciseState {
  final List<Task> tasks;
  FetchedTasksState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}

class FetchedWorkoutExerciseState extends ExerciseState {
  final List<Workout> workouts;
  FetchedWorkoutExerciseState({required this.workouts});
  @override
  List<Object> get props => [workouts];
}

class FetchedTrainingPlansState extends ExerciseState {
  final List<TrainingPlanOverviewDTO> trainingPlans;
  FetchedTrainingPlansState({required this.trainingPlans});
  @override
  List<Object> get props => [trainingPlans];
}

class ExercisesLoadingState extends ExerciseState {
  ExercisesLoadingState();
  @override
  List<Object> get props => [];
}

class ExerciseTypesErrorState extends ExerciseState {
  ExerciseTypesErrorState();
  @override
  List<Object> get props => [];
}

// ENDURANCE

class CreatedEnduranceState extends ExerciseState {
  CreatedEnduranceState();
  @override
  List<Object> get props => [];
}

class UpdatedEnduranceState extends ExerciseState {
  UpdatedEnduranceState();
  @override
  List<Object> get props => [];
}

class DeletedEnduranceState extends ExerciseState {
  DeletedEnduranceState();
  @override
  List<Object> get props => [];
}

// INTERVAL

class CreatedIntervalState extends ExerciseState {
  CreatedIntervalState();
  @override
  List<Object> get props => [];
}

class UpdatedIntervalState extends ExerciseState {
  UpdatedIntervalState();
  @override
  List<Object> get props => [];
}

class DeletedIntervalState extends ExerciseState {
  DeletedIntervalState();
  @override
  List<Object> get props => [];
}

// Strengthening

class CreatedStrengtheningState extends ExerciseState {
  CreatedStrengtheningState();
  @override
  List<Object> get props => [];
}

class UpdatedStrengtheningState extends ExerciseState {
  UpdatedStrengtheningState();
  @override
  List<Object> get props => [];
}

class DeletedStrengtheningState extends ExerciseState {
  DeletedStrengtheningState();
  @override
  List<Object> get props => [];
}

// Hypertrophy

class CreatedHypertrophyState extends ExerciseState {
  CreatedHypertrophyState();
  @override
  List<Object> get props => [];
}

class UpdatedHypertrophyState extends ExerciseState {
  UpdatedHypertrophyState();
  @override
  List<Object> get props => [];
}

class DeletedHypertrophyState extends ExerciseState {
  DeletedHypertrophyState();
  @override
  List<Object> get props => [];
}

// OTHER
class CreatedTaskState extends ExerciseState {
  CreatedTaskState();
  @override
  List<Object> get props => [];
}

class UpdatedTaskState extends ExerciseState {
  UpdatedTaskState();
  @override
  List<Object> get props => [];
}

class DeletedTaskState extends ExerciseState {
  DeletedTaskState();
  @override
  List<Object> get props => [];
}

class CreatedOtherState extends ExerciseState {
  CreatedOtherState();
  @override
  List<Object> get props => [];
}

class UpdatedOtherState extends ExerciseState {
  UpdatedOtherState();
  @override
  List<Object> get props => [];
}

class DeletedOtherState extends ExerciseState {
  DeletedOtherState();
  @override
  List<Object> get props => [];
}

class CreatedWorkoutState extends ExerciseState {
  CreatedWorkoutState();
  @override
  List<Object> get props => [];
}

class UpdatedWorkoutState extends ExerciseState {
  UpdatedWorkoutState();
  @override
  List<Object> get props => [];
}

class DeletedWorkoutState extends ExerciseState {
  DeletedWorkoutState();
  @override
  List<Object> get props => [];
}

class CreatedTrainingPlanState extends ExerciseState {
  CreatedTrainingPlanState();
  @override
  List<Object> get props => [];
}

class UpdatedTrainingPlanState extends ExerciseState {
  UpdatedTrainingPlanState();
  @override
  List<Object> get props => [];
}

class DeletedTrainingPlanState extends ExerciseState {
  DeletedTrainingPlanState();
  @override
  List<Object> get props => [];
}

// GENERELL
class CreatedExerciseState extends ExerciseState {
  CreatedExerciseState();
  @override
  List<Object> get props => [];
}

class UpdatedExerciseState extends ExerciseState {
  UpdatedExerciseState();
  @override
  List<Object> get props => [];
}

class DeletedExerciseState extends ExerciseState {
  DeletedExerciseState();
  @override
  List<Object> get props => [];
}
