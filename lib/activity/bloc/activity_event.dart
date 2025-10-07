part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  final String patientId = "";
  ActivityEvent();

  @override
  List<Object> get props => [patientId];
}

class AddActivityEvent extends ActivityEvent {
  final ActivityPostDTO activity;
  final String patientId;
  final ActivityType type;

  AddActivityEvent({required this.activity, required this.patientId, required this.type});

  @override
  List<Object> get props => [activity, patientId];
}

class AddPersonalGoalEvent extends ActivityEvent {
  final PersonalGoalPostDTO goal;
  final String patientId;

  AddPersonalGoalEvent({required this.goal, required this.patientId});

  @override
  List<Object> get props => [goal, patientId];
}

class UpdatePersonalGoalEvent extends ActivityEvent {
  final PersonalGoalPostDTO goal;
  final String id;
  final String patientId;

  UpdatePersonalGoalEvent({required this.goal, required this.id, required this.patientId});

  @override
  List<Object> get props => [goal, id, patientId];
}

class DeletePersonalGoalEvent extends ActivityEvent {
  final String patientId;
  final String id;

  DeletePersonalGoalEvent({required this.patientId, required this.id});

  @override
  List<Object> get props => [patientId, id];
}

class ResetActivityEvent extends ActivityEvent {
  ResetActivityEvent();

  @override
  List<Object> get props => [];
}

class AddExtraActivityEvent extends ActivityEvent {
  final ExtraActivityPostDTO activity;
  final String patientId;

  AddExtraActivityEvent({required this.activity, required this.patientId});

  @override
  List<Object> get props => [activity, patientId];
}

class UpdateActivityEvent extends ActivityEvent {
  final ActivityPostDTO activity;
  final String id;
  final String patientId;
  final ActivityType type;

  UpdateActivityEvent({required this.activity, required this.id, required this.patientId, required this.type});

  @override
  List<Object> get props => [activity, id, patientId];
}

class FetchAutocompleteEvent extends ActivityEvent {
  FetchAutocompleteEvent();

  List<Object> get props => [];
}

class DeleteActivityEvent extends ActivityEvent {
  final String id;
  final String patientId;
  final DateTime activityDate;
  final ActivityType type;

  DeleteActivityEvent({required this.activityDate, required this.id, required this.patientId, required this.type});

  @override
  List<Object> get props => [activityDate, id, patientId];
}

class FetchPatientActivitiesEvent extends ActivityEvent {
  final String patientId;
  final DateTime date;
  final bool setDate;

  FetchPatientActivitiesEvent({required this.patientId, required this.date, this.setDate = false});

  @override
  List<Object> get props => [patientId, date];
}

//Patient Rating
class UpdateActivityRatingEvent extends ActivityEvent {
  final ActivityPatientRatingPostDTO rating;
  final ActivityType activityType;
  final String id;
  final String patientId;
  final String date;
  final String extraActivityName;

  UpdateActivityRatingEvent({
    required this.rating,
    required this.activityType,
    required this.id,
    required this.patientId,
    required this.date,
    this.extraActivityName = "",
  });

  @override
  List<Object> get props => [rating, id, patientId, extraActivityName];
}

// ACTIVE MINUTES
class FetchActiveMinutesEvent extends ActivityEvent {
  final DateTime startDate;
  final DateTime endDate;
  final ActiveMinutesType type;
  final String patientId;

  FetchActiveMinutesEvent({
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.patientId,
  });

  @override
  List<Object> get props => [startDate, endDate, type, patientId];
}

class ChangeTimeframeEvent extends ActivityEvent {
  ChangeTimeframeEvent();

  @override
  List<Object> get props => [];
}

class HideActivityEvent extends ActivityEvent {
  final DateTime currentDate;
  final HideActivityPostDTO hideActivity;
  final String patientId;

  HideActivityEvent({required this.currentDate, required this.hideActivity, required this.patientId});

  @override
  List<Object> get props => [currentDate, hideActivity, patientId];
}

class MoveActivityEvent extends ActivityEvent {
  final MoveActivityPostDTO moveActivity;

  MoveActivityEvent({required this.moveActivity});

  @override
  List<Object> get props => [moveActivity];
}

class MovePersonalGoalEvent extends ActivityEvent {
  final MovePersonalGoalPostDTO movePersonalGoal;

  MovePersonalGoalEvent({required this.movePersonalGoal});

  @override
  List<Object> get props => [movePersonalGoal];
}
