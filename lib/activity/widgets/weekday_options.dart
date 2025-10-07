import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:flutter/material.dart';

class WeekdayOptions extends StatelessWidget {
  final List<int> selectedDays;
  final Function toggleDay;
  final bool invalidInput;

  WeekdayOptions({
    Key? key,
    required this.selectedDays,
    required this.toggleDay,
    required this.invalidInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 40;
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
              ),
              for (int i = 1; i < 8; i++)
                InkWell(
                  onTap: () => toggleDay(i),
                  child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: selectedDays.contains(i) ? selectedDayColor : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(DayOfWeek.values[i - 1].getTranslatedShortName(context),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      )),
                ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          if (invalidInput)
            Container(
              transform: Matrix4.translationValues(15, -8, 0),
              child: Text(
                context.i18n.validationNotEmpty,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
