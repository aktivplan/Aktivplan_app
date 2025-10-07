import 'dart:async';

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_repository.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/user/user_controller_repository.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository activityRepository;
  final MessageRepository messageRepository;

  ActivityBloc({
    required this.activityRepository,
    required this.messageRepository,
  }) : super(ActivityInitial()) {
    on<ResetActivityEvent>((event, emit) async {
      emit(ActivityInitial());
    });

    on<AddActivityEvent>((event, emit) async {
      await activityRepository.createActivity(activity: event.activity);
      MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(
            category: EVENT_CATEGORY_ACTIVITY,
            name: EVENT_NAME_CREATE,
            action: "Planned Activity with Type ${event.type}",
          ),
          dimensions: {"Start Date": event.activity.startDate ?? "", "End Date": event.activity.endDate ?? ""});
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.activity.startDate ?? "")));
    });

    // EXTRA ACTIVITY
    on<AddExtraActivityEvent>((event, emit) async {
      await activityRepository.createExtraActivity(activity: event.activity);
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVITY,
          name: EVENT_NAME_CREATE,
          action: "Planned Activity with Type ${ActivityType.EXTRA}",
        ),
      );
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.activity.date ?? "")));
    });

    // ACTIVITY
    on<FetchPatientActivitiesEvent>((event, emit) async {
      DateTime startDate;
      DateTime endDate;
      startDate = DateTime(event.date.year, event.date.month - 1, 1);
      while (startDate.weekday != 1) {
        startDate = startDate.subtract(Duration(days: 1));
      }
      endDate = DateTime(event.date.year, event.date.month + 2, 0);
      while (endDate.weekday != 7) {
        endDate = endDate.add(Duration(days: 1));
      }

      final UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();
      DateTime now = DateTime.now();
      DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
      DateTime weekEnd = now.add(Duration(days: (7 - now.weekday)));

      final responses = await Future.wait([
        this.activityRepository.getPatientActivities(patientId: event.patientId, startDate: startDate, endDate: endDate),
        this.activityRepository.getActiveMinutes(weekEnd, weekStart, ActiveMinutesType.WEEK, patientId: event.patientId),
        activityRepository.getPersonalGoals(patientId: event.patientId),
        userControllerRepository.getPatientbyId(id: event.patientId),
        userControllerRepository.getUserPicture(id: event.patientId, userRole: UserRole.PATIENT),
      ]);

      emit(
        FetchedPatientActivitiesState(
          activities: responses[0] as List<ActivityOverviewDTO>,
          activeMinutes: responses[1] as ActiveMinutesOverviewDTO,
          personalGoals: responses[2] as List<PersonalGoal>,
          patient: responses[3] as PatientOverviewDTO,
          userPicture: responses[4] as FileGetDTO,
          date: event.setDate ? event.date : null,
        ),
      );
    });

    // UPDATE
    on<UpdateActivityEvent>((event, emit) async {
      await activityRepository.updateActivity(id: event.id, activity: event.activity);
      MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(
            category: EVENT_CATEGORY_ACTIVITY,
            name: EVENT_NAME_UPDATE,
            action: "Updated Planned Activity with Type ${event.type}",
          ),
          dimensions: {"Start Date": event.activity.startDate ?? "", "End Date": event.activity.endDate ?? ""});
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.activity.startDate ?? "")));
    });

    //DELETE
    on<DeleteActivityEvent>((event, emit) async {
      await activityRepository.deleteActivity(id: event.id);
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_ACTIVITY, name: EVENT_NAME_DELETE, action: "Deleted Planned Activity with Type ${event.type}"),
      );
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: event.activityDate));
      emit(ActivityWaitingState());
    });

    on<FetchAutocompleteEvent>((event, emit) async {
      ActivityAutocompleteGetDTO autocomplete = await activityRepository.fetchAutocomplete() ?? ActivityAutocompleteGetDTO();
      emit(AutocompleteState(autocomplete: autocomplete));
    });

    // PERSONAL GOALS
    on<AddPersonalGoalEvent>((event, emit) async {
      await activityRepository.createPersonalGoal(personalGoal: event.goal);
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.goal.endDate ?? ""), setDate: true));
    });

    on<UpdatePersonalGoalEvent>((event, emit) async {
      await activityRepository.updatePersonalGoal(id: event.id, personalGoal: event.goal);
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.goal.endDate ?? ""), setDate: true));
      emit(ActivityWaitingState());
    });

    on<DeletePersonalGoalEvent>((event, emit) async {
      await activityRepository.deletePersonalGoal(id: event.id);
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.now(), setDate: true));
      emit(ActivityWaitingState());
    });

    //PATIENT RATING
    on<UpdateActivityRatingEvent>((event, emit) async {
      if (event.activityType == ActivityType.EXTRA && event.extraActivityName.isNotEmpty) {
        await activityRepository.updateExtraActivity(id: event.id, activity: ExtraActivityPutDTO(name: event.extraActivityName));
      }
      await activityRepository.updateActivityRating(id: event.id, date: event.date, activityPatientRating: event.rating);
      this.add(FetchPatientActivitiesEvent(patientId: event.patientId, date: DateTime.parse(event.date)));
      emit(UpdatePatientActivityRatingState(activityId: event.id, date: event.date, rating: event.rating));
    });

    on<ChangeTimeframeEvent>((event, emit) async {
      emit(ActivityWaitingState());
    });

    // ACTIVE MINUTES
    on<FetchActiveMinutesEvent>((event, emit) async {
      emit(ActivityWaitingState());
      ActiveMinutesOverviewDTO activeMinutes = await activityRepository.getActiveMinutes(
            event.endDate,
            event.startDate,
            event.type,
            patientId: event.patientId,
          ) ??
          ActiveMinutesOverviewDTO();
      emit(FetchedActiveMinutesState(activeMinutes: activeMinutes));
    });

    on<HideActivityEvent>((event, emit) async {
      await activityRepository.hideActivity(event.hideActivity);
      if (event.hideActivity.hideDate.isNotEmpty && !event.hideActivity.hideAll) {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(
            category: EVENT_CATEGORY_ACTIVITY,
            name: EVENT_NAME_HIDE,
            action: "Hid Activity at Single Date",
          ),
        );
      } else {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_ACTIVITY, name: EVENT_NAME_HIDE, action: "Hid all activities"),
        );
      }
      add(FetchPatientActivitiesEvent(patientId: event.patientId, date: event.currentDate));
    });

    on<MoveActivityEvent>((event, emit) async {
      final movedActivity = await activityRepository.moveActivity(event.moveActivity);
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_ACTIVITY, name: EVENT_NAME_MOVE, action: "Moved Activity"),
      );
      add(FetchPatientActivitiesEvent(patientId: movedActivity?.patientId ?? "", date: DateTime.parse(event.moveActivity.toDate ?? "")));
    });

    on<MovePersonalGoalEvent>((event, emit) async {
      final movedGoal = await activityRepository.movePersonalGoal(event.movePersonalGoal);
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_MOVE, action: "Moved Personal Goal"),
      );
      add(FetchPatientActivitiesEvent(patientId: movedGoal?.patientId ?? "", date: DateTime.parse(event.movePersonalGoal.toDate ?? "")));
    });
  }

  Stream<ActivityState> mapEventToState(
    ActivityEvent event,
  ) async* {
    try {} on Exception catch (e) {
      print(e.toString());
      yield ActivityErrorState(message: e.toString());
    }
  }
}
