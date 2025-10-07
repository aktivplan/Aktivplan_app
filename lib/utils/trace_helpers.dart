import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

String getCurrentPath(BuildContext context) {
  return (Beamer.of(context).currentBeamLocation.state as BeamState).uri.toString().substring(1);
}

const String EVENT_CATEGORY_LIFE_CYCLE = "App Life Cycle";
const String EVENT_NAME_CHANGE_LIFE_CYCLE = "Change App Life Cycle";
const String EVENT_NAME_FOREGROUND = "Foreground (seconds)";
const String EVENT_SHARE = "Share";

const String EVENT_CATEGORY_EXERCISE = "Exercise";
const String EVENT_CATEGORY_TRAINING_PLAN = "Exercise Plan";
const String EVENT_CATEGORY_ACTIVITY = "Activity";
const String EVENT_CATEGORY_PATIENT = "Patient";
const String EVENT_CATEGORY_PATIENT_NOTES = "Patient Notes";
const String EVENT_CATEGORY_PATIENT_STATE = "Patient State";
const String EVENT_CATEGORY_PERSONAL_GOAL = "Personal Goal";
const String EVENT_CATEGORY_PATIENT_PROFILE = "Patient Profile";
const String EVENT_NAME_CREATE = "Create";
const String EVENT_NAME_UPDATE = "Update";
const String EVENT_NAME_DELETE = "Delete";
const String EVENT_NAME_COPY = "Copy";
const String EVENT_NAME_HIDE = "Hide";
const String EVENT_NAME_DONE = "Done";
const String EVENT_NAME_UNDONE = "Undone";
const String EVENT_NAME_MOVE = "Move";
const String EVENT_NAME_RATE_ACTIVITY_TIME = "Time Till Activity Rated (seconds)";
const String EVENT_NAME_RATE_ACTIVITY_VALUE = "Rated Activity (BORG value)";

const String EVENT_CATEGORY_ACTIVE_MINUTES = "Active Minutes";
const String EVENT_NAME_CHANGE_TIME_SELECTION = "Change Time Selection";
const String EVENT_NAME_CHANGE_TAB = "Change Tab";

const String EVENT_CATEGORY_DOWNLOAD = "Download";
const String EVENT_NAME_DOWNLOAD_CSV = "Download CSV";
const String EVENT_NAME_DOWNLOAD_PDF = "Download PDF";

const String EVENT_CATEGORY_FINAL_CHECK = "Final Check";
const String EVENT_NAME_TICK_FINAL_CHECK = "Tick Final Check Checkboxes";

const String EVENT_CATEGORY_PUSH_NOTIFICATION = "Push Notification";
const String EVENT_NAME_RECEIVE = "Receive";
const String EVENT_NAME_OPEN = "Open";

const String EVENT_CATEGORY_MESSAGE_TEMPLATE = "Message Template";
const String EVENT_CATEGORY_PATIENT_MESSAGE = "Patient Message";
const String EVENT_CATEGORY_PATIENT_SCHEDULE_MESSAGE = "Patient Schedule Message";
const String EVENT_NAME_SENT_PATIENT_MESSAGE = "Sent Patient Message";
const String EVENT_NAME_SCHEDULED_PATIENT_MESSAGE = "Scheduled Patient Message";
