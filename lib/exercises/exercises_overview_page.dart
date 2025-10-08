// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/endurance_exercises_table.dart';
import 'package:aptapp/exercises/exercise_categories.dart';
import 'package:aptapp/exercises/hypertrophy_exercises_table.dart';
import 'package:aptapp/exercises/interval_exercises_table.dart';
import 'package:aptapp/exercises/other_exercises_table.dart';
import 'package:aptapp/exercises/strengthening_exercises_table.dart';
import 'package:aptapp/exercises/tasks_table.dart';
import 'package:aptapp/exercises/training_plans_table.dart';
import 'package:aptapp/exercises/workout_table.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExerciseOverviewPage extends StatefulWidget {
  final String pathType;
  ExerciseOverviewPage({Key? key, this.pathType = ""}) : super(key: key);

  @override
  _ExerciseOverviewPageState createState() => _ExerciseOverviewPageState();
}

class _ExerciseOverviewPageState extends State<ExerciseOverviewPage> with SingleTickerProviderStateMixin, TraceablePageMixin {
  ExerciseBloc? exerciseBloc;
  ExerciseState? previousState;
  ExerciseState? currentState;

  @override
  void initState() {
    super.initState();
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    if (widget.pathType.isNotEmpty) {
      exerciseBloc!.add(ExerciseTypesLoadingEvent());
      ExerciseType type =
          ExerciseType.values.firstWhere((element) => element.toString() == widget.pathType.toUpperCase(), orElse: () => ExerciseType.ALL);
      getCategoryExerciseTypes(type, widget.pathType == 'workout', widget.pathType == 'plan');
    } else {
      exerciseBloc!.add(ExerciseTypesHomeEvent());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCategoryExerciseTypes(ExerciseType? type, bool isWorkout, bool isTrainingPlan) {
    if (isWorkout) {
      exerciseBloc!.add(FetchWorkoutExerciseEvent());
      return;
    }
    if (isTrainingPlan) {
      exerciseBloc!.add(FetchTrainingPlansEvent());
      return;
    }
    switch (type) {
      case ExerciseType.ENDURANCE:
        exerciseBloc!.add(FetchEnduranceExercisesEvent());
        break;
      case ExerciseType.INTERVAL:
        exerciseBloc!.add(FetchIntervalExerciseEvent());
        break;
      case ExerciseType.STRENGTHENING:
        exerciseBloc!.add(FetchStrengtheningExercisesEvent());
        break;
      case ExerciseType.HYPERTROPHY:
        exerciseBloc!.add(FetchHypertrophyExerciseEvent());
        break;
      case ExerciseType.OTHER:
        exerciseBloc!.add(FetchOtherExercisesEvent());
        break;
      case ExerciseType.TASK:
        exerciseBloc!.add(FetchTasksEvent());
        break;
      default:
        exerciseBloc!.add(ExerciseTypesErrorEvent());
        break;
    }
  }

  getHome() {
    exerciseBloc!.add(ExerciseTypesHomeEvent());
    context.beamToNamed('/training');
  }

  addExercise(ExerciseType type) {
    context.beamToNamed(
      '/training/${type.value.toLowerCase()}/add',
      data: {
        'exerciseType': type,
      },
    );
  }

  addWorkout() {
    context.beamToNamed('/workout/add');
  }

  addTrainingPlan() {
    context.beamToNamed('/training/plan/add');
  }

  editExerciseType(var exercise) {
    context.beamToNamed(
      '/training/${exercise.type.toString().toLowerCase()}/${exercise.id}/edit',
      data: {
        'exerciseType': exercise.type,
        'exercise': exercise,
      },
    );
  }

  editWorkout(Workout workout) {
    context.beamToNamed(
      '/workout/edit',
      data: {
        'workout': workout,
      },
    );
  }

  editTrainingPlan(TrainingPlanOverviewDTO trainingPlan, bool isCopy) {
    context.beamToNamed('/training/plan/${trainingPlan.id}/${isCopy ? 'copy' : 'edit'}');
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return BlocConsumer<ExerciseBloc, ExerciseState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            var snackBar;
            //uncomment bloc to turn of snackbar
            if (state is CreatedEnduranceState) {
              snackBar = getSnackbar(context.i18n.addedExercise_ENDURANCE, size.isMobile, context);
            } else if (state is UpdatedEnduranceState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_ENDURANCE, size.isMobile, context);
            } else if (state is DeletedEnduranceState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_ENDURANCE, size.isMobile, context);
            } // INTERVAL
            else if (state is CreatedIntervalState) {
              snackBar = getSnackbar(context.i18n.addedExercise_INTERVAL, size.isMobile, context);
            } else if (state is UpdatedIntervalState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_INTERVAL, size.isMobile, context);
            } else if (state is DeletedIntervalState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_INTERVAL, size.isMobile, context);
            } // STRENGTHENING
            else if (state is CreatedStrengtheningState) {
              snackBar = getSnackbar(context.i18n.addedExercise_STRENGTHENING, size.isMobile, context);
            } else if (state is UpdatedStrengtheningState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_STRENGTHENING, size.isMobile, context);
            } else if (state is DeletedStrengtheningState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_STRENGTHENING, size.isMobile, context);
            } // HYPERTROPHY
            else if (state is CreatedHypertrophyState) {
              snackBar = getSnackbar(context.i18n.addedExercise_HYPERTROPHY, size.isMobile, context);
            } else if (state is UpdatedHypertrophyState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_HYPERTROPHY, size.isMobile, context);
            } else if (state is DeletedHypertrophyState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_HYPERTROPHY, size.isMobile, context);
            }
            // WORKOUT
            else if (state is CreatedWorkoutState) {
              snackBar = getSnackbar(context.i18n.addedWorkout, size.isMobile, context);
            } else if (state is UpdatedWorkoutState) {
              snackBar = getSnackbar(context.i18n.updatedWorkout, size.isMobile, context);
            } else if (state is DeletedWorkoutState) {
              snackBar = getSnackbar(context.i18n.deletedWorkout, size.isMobile, context);
            }
            // OTHER
            else if (state is CreatedOtherState) {
              snackBar = getSnackbar(context.i18n.addedExercise_OTHER, size.isMobile, context);
            } else if (state is UpdatedOtherState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_OTHER, size.isMobile, context);
            } else if (state is DeletedOtherState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_OTHER, size.isMobile, context);
            }
            // TASK
            else if (state is CreatedTaskState) {
              snackBar = getSnackbar(context.i18n.addedExercise_TASK, size.isMobile, context);
            } else if (state is UpdatedTaskState) {
              snackBar = getSnackbar(context.i18n.updatedExercise_TASK, size.isMobile, context);
            } else if (state is DeletedTaskState) {
              snackBar = getSnackbar(context.i18n.deletedExercise_TASK, size.isMobile, context);
            }
            // Training Plan
            else if (state is CreatedTrainingPlanState) {
              snackBar = getSnackbar(context.i18n.addedTrainingPlan, size.isMobile, context);
            } else if (state is UpdatedTrainingPlanState) {
              snackBar = getSnackbar(context.i18n.updatedTrainingPlan, size.isMobile, context);
            } else if (state is DeletedTrainingPlanState) {
              snackBar = getSnackbar(context.i18n.deletedTrainingPlan, size.isMobile, context);
            } else if (state is ExerciseTypesErrorState) {
              snackBar = getSnackbar(
                context.i18n.error,
                size.isMobile,
                context,
                error: true,
              );
            }

            if (snackBar != null) {
              snackBar.show(context);
              snackBar = null;
            }
          },
          buildWhen: (previous, state) {
            return state is FetchedEnduranceExercisesState ||
                state is FetchedIntervalExerciseState ||
                state is FetchedStrengtheningExercisesState ||
                state is FetchedHypertrophyExerciseState ||
                state is FetchedWorkoutExerciseState ||
                state is FetchedOtherExerciseState ||
                state is FetchedTasksState ||
                state is FetchedTrainingPlansState ||
                state is ExerciseInitial ||
                state is ExercisesLoadingState;
          },
          builder: (context, state) {
            String addButtonTitle = context.i18n.addExercise;
            if (state is FetchedWorkoutExerciseState) {
              addButtonTitle = context.i18n.addWorkout;
            } else if (state is FetchedTrainingPlansState) {
              addButtonTitle = context.i18n.addTrainingPlan;
            } else if (state is FetchedTasksState) {
              addButtonTitle = context.i18n.addTask;
            }
            return AptLayout(
              key: Key(KEY_EXERCISES_SCROLL_VIEW),
              border: !(state is ExerciseInitial),
              breadCrumb: getBreadcrumb(state),
              fixedHeight: !(state is ExerciseInitial),
              children: [
                Builder(
                  builder: (context) {
                    if (state is ExerciseInitial) {
                      return ExerciseCategories(
                        optionCallback: getCategoryExerciseTypes,
                        hideTrainingPlan: !userRepository.showTrainingPlans,
                      );
                    } else if (state is FetchedWorkoutExerciseState) {
                      return WorkoutTable(fetchedWorkouts: state.workouts, editWorkout: editWorkout);
                    } else if (state is FetchedIntervalExerciseState) {
                      return IntervalExerciseTypesTable(
                        fetchedExerciseTypes: state.exercises,
                        editExerciseType: editExerciseType,
                      );
                    } else if (state is FetchedEnduranceExercisesState) {
                      return EnduranceExercisesTable(
                        fetchedExercises: state.exercises,
                        editExercise: editExerciseType,
                      );
                    } else if (state is FetchedStrengtheningExercisesState) {
                      return StrengtheningExercisesTable(
                        fetchedExerciseTypes: state.exercises,
                        editExercise: editExerciseType,
                      );
                    } else if (state is FetchedHypertrophyExerciseState) {
                      return HypertrophyExerciseTypesTable(
                        fetchedExerciseTypes: state.exercises,
                        editExerciseType: editExerciseType,
                      );
                    } else if (state is FetchedOtherExerciseState) {
                      return OtherExercisesTable(fetchedExercises: state.exercises, editExercise: editExerciseType);
                    } else if (state is FetchedTasksState) {
                      return TasksTable(fetchedTasks: state.tasks, editExercise: editExerciseType);
                    } else if (state is FetchedTrainingPlansState) {
                      return TrainingPlansTable(
                        canCopy: true,
                        fetchedTrainingPlans: state.trainingPlans,
                        editTrainingPlan: editTrainingPlan,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
              addButton: !(state is ExerciseInitial)
                  ? RoundedIconButton(
                      title: addButtonTitle,
                      callback: () {
                        if (state is FetchedWorkoutExerciseState) {
                          addWorkout();
                        } else if (state is FetchedTrainingPlansState) {
                          addTrainingPlan();
                        } else {
                          addExercise(getTypeForState(state)!);
                        }
                      },
                    )
                  : null,
            );
          },
        );
      },
    );
  }

  List<BreadCrumbItem> getBreadcrumb(ExerciseState state) {
    final style = getBreadCrumbStyle(context);

    final breadCrumb = [
      BreadCrumbItem(
        content: TextButton(
          key: Key(KEY_EXERCISES_BREAD_CRUMB_EXERCISES),
          onPressed: getHome,
          child: Text(
            context.i18n.activities,
            style: getTypeForState(state) == null && !(state is FetchedWorkoutExerciseState) && !(state is FetchedTrainingPlansState)
                ? style
                : style?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
      )
    ];
    if (state is FetchedWorkoutExerciseState) {
      breadCrumb.add(BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.workout, style: style))));
    } else if (state is FetchedIntervalExerciseState) {
      breadCrumb.add(
          BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_INTERVAL, style: style))));
    } else if (state is FetchedEnduranceExercisesState) {
      breadCrumb.add(
          BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_ENDURANCE, style: style))));
    } else if (state is FetchedStrengtheningExercisesState) {
      breadCrumb.add(BreadCrumbItem(
          content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_STRENGTHENING, style: style))));
    } else if (state is FetchedHypertrophyExerciseState) {
      breadCrumb.add(BreadCrumbItem(
          content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_HYPERTROPHY, style: style))));
    } else if (state is FetchedOtherExerciseState) {
      breadCrumb
          .add(BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_OTHER, style: style))));
    } else if (state is FetchedTasksState) {
      breadCrumb
          .add(BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.exercise_TASK, style: style))));
    } else if (state is FetchedTrainingPlansState) {
      breadCrumb
          .add(BreadCrumbItem(content: Padding(padding: EdgeInsets.only(left: 8), child: SelectableText(context.i18n.trainingPlan, style: style))));
    }
    return breadCrumb;
  }

  ExerciseType? getTypeForState(ExerciseState state) {
    if (state is FetchedIntervalExerciseState) {
      return ExerciseType.INTERVAL;
    } else if (state is FetchedEnduranceExercisesState) {
      return ExerciseType.ENDURANCE;
    } else if (state is FetchedStrengtheningExercisesState) {
      return ExerciseType.STRENGTHENING;
    } else if (state is FetchedHypertrophyExerciseState) {
      return ExerciseType.HYPERTROPHY;
    } else if (state is FetchedOtherExerciseState) {
      return ExerciseType.OTHER;
    } else if (state is FetchedTasksState) {
      return ExerciseType.TASK;
    }
    return null;
  }

  String get traceablePageName => "Exercises Overview Page";
}
