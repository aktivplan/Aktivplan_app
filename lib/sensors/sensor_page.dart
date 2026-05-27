import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/sensors/bloc/sensor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

class SensorPage extends StatefulWidget {
  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  String dates = "";
  late DateTime start;
  late DateTime end;
  late SensorBloc sensorBloc;

  @override
  void initState() {
    super.initState();
    sensorBloc = BlocProvider.of<SensorBloc>(context);
    initializeTimes();
    BlocProvider.of<SensorBloc>(context)
      ..add(FetchSensorEvent(
        startDate: start,
        endDate: end,
        healthDataTypeList: [HealthDataType.HEART_RATE, HealthDataType.WORKOUT, HealthDataType.STEPS, HealthDataType.SLEEP_ASLEEP],
      ));
  }

  Widget renderHealthData(HealthDataPoint healthData) {
    return ListTile(
      minLeadingWidth: 10,
      contentPadding: EdgeInsets.zero,
      leading: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Icon(Icons.circle,
            size: 10,
            color: healthData.type == HealthDataType.STEPS
                ? extraActivityColor
                : healthData.type == HealthDataType.HEART_RATE
                    ? goalColor
                    : accentColor),
      ),
      title: SelectableText("${healthData.typeString}: ${healthData.value}"),
      subtitle: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SelectableText("${healthData.dateFrom} - ${healthData.dateTo}"),
            ],
          ),
        ),
      ]),
    );
  }

  initializeTimes() {
    end = DateTime.now();
    start = DateTime(end.year, end.month, end.day);
    String startString = DateFormat('dd.MM.yyyy', 'de').format(start);
    dates = "$startString";
  }

  updateTimes(bool getBefore) {
    if (getBefore) {
      setState(() {
        start = start.subtract(Duration(days: 1));
        end = end.subtract(Duration(days: 1));
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start);
        dates = "$startString";
      });
    } else {
      setState(() {
        start = start.add(Duration(days: 1));
        end = end.add(Duration(days: 1));
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start);
        dates = "$startString";
      });
    }
    sensorBloc.add(FetchSensorEvent(
      startDate: start,
      endDate: end,
      healthDataTypeList: [HealthDataType.HEART_RATE, HealthDataType.WORKOUT, HealthDataType.STEPS, HealthDataType.SLEEP_ASLEEP],
    ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double cardHeight = height * 0.6;
    String currentDates = dates;
    DateFormat dateFormat = DateFormat("HH:mm");

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.i18n.notifications),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocBuilder<SensorBloc, SensorState>(
          builder: (context, state) {
            if (state is FetchSensorState) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () => updateTimes(true),
                      ),
                      Column(
                        children: [
                          SelectableText(currentDates, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () => updateTimes(false),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SelectableText(
                          "Work Out",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightTextColor, letterSpacing: 1.1),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: cardHeight,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: state.healthWorkOutDataList.length,
                              itemBuilder: (_, index) {
                                HealthDataPoint p = state.healthWorkOutDataList[index];
                                return ListTile(
                                  title: Text(
                                      "${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}"),
                                  trailing: Text('${(p.value as WorkoutHealthValue).workoutActivityType.name}'),
                                  subtitle: Text('${dateFormat.format(p.dateFrom)} - ${dateFormat.format(p.dateTo)}'),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
