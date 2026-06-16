import 'package:aptapp/colors.dart';
import 'package:aptapp/polar/bloc/polar_bloc.dart';
import 'package:aptapp/polar/bloc/polar_event.dart';
import 'package:aptapp/polar/bloc/polar_repository.dart';
import 'package:aptapp/polar/bloc/polar_state.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeartRateButton extends StatefulWidget {
  @override
  _HeartRateButtonState createState() => _HeartRateButtonState();
}

class _HeartRateButtonState extends State<HeartRateButton> {
  int heartRate = 0;
  String deviceId = "";
  @override
  void initState() {
    super.initState();
    PolarBloc polarBloc = BlocProvider.of<PolarBloc>(context);
    polarBloc.add(PolarInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolarBloc, PolarState>(builder: (context, state) {
      PolarRepository.getPolarDeviceId().then((value) => setState(() => deviceId = value));
      Color heartColor = Colors.grey;
      if (state is HeartRateDataState) {
        heartRate = state.heartRate;
        heartColor = trafficLight1;
      } else if (deviceId.isNotEmpty) {
        heartColor = infoIconColor;
      }
      if (state is DeviceDisconnectedState) {
        heartRate = 0;
        heartColor = deviceId.isNotEmpty ? infoIconColor : Colors.grey;
      }
      double size = 20;
      double fontSize = 13;

      return Padding(
        padding: EdgeInsets.only(right: 0),
        child: Align(
          alignment: Alignment.center,
          child: Stack(children: [
            IconButton(
              key: Key(KEY_BUTTON_NOTIFICATIONS),
              color: heartColor,
              iconSize: 40.0,
              icon: Icon(Icons.favorite),
              onPressed: () {
                context.beamToNamed("/polar-search");
              },
            ),
            Positioned(
              right: 18,
              top: 18,
              child: Container(
                padding: EdgeInsets.all(1),
                constraints: BoxConstraints(
                  minWidth: size + 1,
                  minHeight: size,
                ),
                child: Text(
                  heartRate > 0 ? '$heartRate' : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
