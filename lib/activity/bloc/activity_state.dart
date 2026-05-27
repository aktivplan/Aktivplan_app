part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityWaitingState extends ActivityState {}

class FetchedPatientActivitiesState extends ActivityState {
  final List<ActivityOverviewDTO> activities;
  final ActiveMinutesOverviewDTO activeMinutes;
  final List<PersonalGoal> personalGoals;
  final PatientOverviewDTO patient;
  final FileGetDTO userPicture;
  final DateTime? date;

  FetchedPatientActivitiesState({
    required this.activities,
    required this.activeMinutes,
    required this.personalGoals,
    required this.patient,
    required this.userPicture,
    required this.date,
  });

  @override
  List<Object> get props => [activities, activeMinutes, personalGoals];
}

class UpdatePatientActivityRatingState extends ActivityState {
  final String activityId;
  final String date;
  final ActivityPatientRatingPostDTO rating;
  UpdatePatientActivityRatingState({required this.activityId, required this.date, required this.rating});

  @override
  List<Object> get props => [activityId, date, rating];
}

class AutocompleteState extends ActivityState {
  final ActivityAutocompleteGetDTO autocomplete;
  AutocompleteState({required this.autocomplete});

  @override
  List<Object> get props => [autocomplete];
}

class ActivityErrorState extends ActivityState {
  final String message;
  ActivityErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ExtraActivityCreatedState extends ActivityState {
  final String activityId;
  const ExtraActivityCreatedState({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

// Active Minutes
class FetchedActiveMinutesState extends ActivityState {
  final ActiveMinutesOverviewDTO activeMinutes;

  FetchedActiveMinutesState({required this.activeMinutes});

  @override
  List<Object> get props => [activeMinutes];
}
