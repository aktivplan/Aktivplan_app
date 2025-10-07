import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/hypertrophy_exercises_table.dart';
import 'package:aptapp/exercises/strengthening_exercises_table.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StrengtheningExercisesOverview extends StatefulWidget {
  final ExerciseType exerciseType;
  final Function() getHome;
  final Function() chooseStrengthExerciseType;
  final Function(StrengtheningExercise, bool) editExerciseType;
  final double containerWidth;

  StrengtheningExercisesOverview(
      {Key? key,
      required this.exerciseType,
      required this.getHome,
      required this.chooseStrengthExerciseType,
      required this.editExerciseType,
      required this.containerWidth})
      : super(key: key);

  @override
  _StrengtheningExercisesOverviewState createState() => _StrengtheningExercisesOverviewState();
}

class _StrengtheningExercisesOverviewState extends State<StrengtheningExercisesOverview> {
  bool isAscending = true;
  List<StrengtheningExercise> exercises = [];

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = !isAscending;
    });
    if (ascending) {
      exercises.sort((a, b) => getTranslatedText(a.name, context).toLowerCase().compareTo(getTranslatedText(b.name, context).toLowerCase()));
    } else {
      exercises.sort((a, b) => getTranslatedText(b.name, context).toLowerCase().compareTo(getTranslatedText(a.name, context).toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(builder: (context, size) {
      return Container(
        width: widget.containerWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldPadding(
              child: BreadCrumb(
                items: [
                  BreadCrumbItem(
                    onTap: () => widget.getHome(),
                    content: Text(
                      context.i18n.workout,
                      style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  BreadCrumbItem(
                    onTap: () => widget.chooseStrengthExerciseType(),
                    content: Text(
                      context.i18n.exerciseWorkoutStrength,
                      key: Key(KEY_WORKOUT_BREAD_CRUMB_EXERCISES),
                      style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  BreadCrumbItem(
                    content: SelectableText(
                      widget.exerciseType.getTranslatedText(context),
                      style: getBreadCrumbStyle(context),
                    ),
                  )
                ],
                divider: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
              if (state is FetchedHypertrophyExerciseState) {
                return Container(
                  height: size.isMobile ? height * 0.6 : height * 0.65,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: datatableBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: HypertrophyExerciseTypesTable(
                      fetchedExerciseTypes: state.exercises, editExerciseType: (exercise) => widget.editExerciseType(exercise, false)),
                );
              } else if (state is FetchedStrengtheningExercisesState) {
                return Container(
                  height: size.isMobile ? height * 0.6 : height * 0.65,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: datatableBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: StrengtheningExercisesTable(
                      fetchedExerciseTypes: state.exercises, editExercise: (exercise) => widget.editExerciseType(exercise, false)),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
          ],
        ),
      );
    });
  }
}
