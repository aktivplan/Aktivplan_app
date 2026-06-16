import 'dart:io';

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/polar/bloc/polar_repository.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'bloc/polar_bloc.dart';
import 'bloc/polar_event.dart';
import 'bloc/polar_state.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceSearchPage extends StatefulWidget {
  @override
  _DeviceSearchPageState createState() => _DeviceSearchPageState();
}

class _DeviceSearchPageState extends State<DeviceSearchPage> {
  PolarBloc? polarBloc;
  late List<PolarDevice> deviceList = [];
  PolarDevice? identifier;
  String _deviceId = "";
  int _tappedConnectedToDeviceIndex = -1;
  double width = 0;
  int batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    polarBloc = BlocProvider.of<PolarBloc>(context);
    getDeviceId();
    checkAndGrantBluthoothPermissions();
    turnOnBluetooth();
  }

  Future<void> getDeviceId() async {
    _deviceId = await PolarRepository.getPolarDeviceId();

    if (await FlutterBluePlus.isSupported == false) {
      return;
    }
  }

  void removeDuplicateItems() {
    Set<PolarDevice> s = deviceList.toSet();
    deviceList = s.toList();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  generalInfoTile(context),
                  Container(
                    width: double.infinity,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      BlocBuilder<PolarBloc, PolarState>(
                        bloc: polarBloc,
                        builder: (context, state) {
                          if (state is DeviceSearchingState) {
                            return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), color: Colors.white),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: double.infinity,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                  SizedBox(height: 10),
                                  Text(
                                    context.i18n.searchingForDevices,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Center(child: CircularProgressIndicator()),
                                  SizedBox(height: 10),
                                ]),
                              ),
                              ElevatedButton(
                                key: Key(KEY_BUTTON_BACK),
                                style: getElevatedButtonStyle(context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text(context.i18n.back.toUpperCase())],
                                ),
                                onPressed: () {
                                  polarBloc?.add(PolarBackEvent());
                                },
                              ),
                            ]);
                          } else if (state is DeviceSearchedState) {
                            deviceList.add(state.device);
                            removeDuplicateItems();
                            return buildDeviceList();
                          } else if (state is DeviceConnectingState) {
                            return buildDeviceList();
                          } else if (state is DeviceConnectedState) {
                            return showSearchAndDisconnectButtons(context);
                          } else if (state is HeartRateDataState) {
                            identifier = state.device;
                            return showSearchAndDisconnectButtons(context);
                          } else if (state is DeviceDisconnectedState) {
                            identifier = null;
                            batteryLevel = 0;
                            _tappedConnectedToDeviceIndex = -1;
                            return showSearchAndDisconnectButtons(context);
                          } else if (state is DeviceBatteryLevelState) {
                            batteryLevel = state.level;
                            return showSearchAndDisconnectButtons(context);
                          } else if (state is PolarErrorState) {
                            return Container(
                              decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), color: Colors.white),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              width: double.infinity,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                Text(
                                  context.i18n.error,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  state.message,
                                ),
                              ]),
                            );
                          }
                          return showSearchAndDisconnectButtons(context);
                        },
                      ),
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  showSearchAndDisconnectButtons(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (identifier != null) connectedDeviceInfoTile(context, identifier!.name),
          ElevatedButton(
            key: Key(KEY_BUTTON_VIEW_POSSIBLE_DEVICES),
            style: getElevatedButtonStyle(context),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(context.i18n.viewPossibleDevices.toUpperCase())],
            ),
            onPressed: identifier == null
                ? () {
                    setState(() {
                      deviceList.clear();
                    });
                    polarBloc?.add(DeviceSearchEvent());
                  }
                : null,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            key: Key(KEY_BUTTON_INTERRUPTING_DEVICE),
            style: getElevatedButtonStyle(context, backgroundColor: identifier == null ? infoIconColor : trafficLight1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(context.i18n.interruptingDevice.toUpperCase())],
            ),
            onPressed: identifier != null || _deviceId.isNotEmpty
                ? () async {
                    polarBloc?.add(DeviceDisconnectEvent(identifier as PolarDevice));
                  }
                : null,
          ),
        ]));
  }

  buildDeviceList() {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), color: Colors.white),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: deviceList.length,
            itemBuilder: (context, index) {
              final device = deviceList[index];
              return ListTile(
                title: Text(device.name),
                trailing: ElevatedButton(
                  child: _tappedConnectedToDeviceIndex == index
                      ? Text(context.i18n.connecting.toUpperCase())
                      : Text(context.i18n.connect.toUpperCase()),
                  onPressed: _tappedConnectedToDeviceIndex == -1
                      ? () => {
                            setState(() {
                              _tappedConnectedToDeviceIndex = index;
                            }),
                            polarBloc?.add(DeviceConnectEvent(device))
                          }
                      : null,
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          key: Key(KEY_BUTTON_BACK),
          style: getElevatedButtonStyle(context),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.i18n.back.toUpperCase())],
          ),
          onPressed: () {
            polarBloc?.add(PolarBackEvent());
          },
        ),
      ]),
    );
  }

  generalInfoTile(BuildContext cntx) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), color: Colors.white),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          cntx.i18n.connectToDevice,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          cntx.i18n.connectToDeviceDescription,
        ),
      ]),
    );
  }

  connectedDeviceInfoTile(BuildContext cntx, String deviceName) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), color: Colors.white),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  cntx.i18n.connectedDevice + ': ',
                  style: Theme.of(cntx).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                ),
                Text(
                  deviceName,
                  style: Theme.of(cntx).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (batteryLevel > 0)
              Row(
                children: [
                  Text(
                    cntx.i18n.batteryLevel + ': ',
                    style: Theme.of(cntx).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(90 / 360),
                    child: getBatteryIcon(batteryLevel),
                  ),
                ],
              ),
          ],
        ));
  }

  Icon getBatteryIcon(int batteryLevel) {
    if (batteryLevel == 0) {
      return Icon(Icons.battery_0_bar);
    } else if (batteryLevel > 0 && batteryLevel <= 10) {
      return Icon(Icons.battery_1_bar);
    } else if (batteryLevel > 10 && batteryLevel <= 30) {
      return Icon(Icons.battery_2_bar);
    } else if (batteryLevel > 30 && batteryLevel <= 50) {
      return Icon(Icons.battery_3_bar);
    } else if (batteryLevel > 50 && batteryLevel <= 70) {
      return Icon(Icons.battery_4_bar);
    } else if (batteryLevel > 70 && batteryLevel <= 90) {
      return Icon(Icons.battery_5_bar);
    } else if (batteryLevel > 90 && batteryLevel < 100) {
      return Icon(Icons.battery_6_bar);
    } else {
      return Icon(Icons.battery_full);
    }
  }

  void _showAlertDialog(BuildContext ctx, String text, String title, String cancelText, Function callback) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            child: Text(cancelText),
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
          ),
          ElevatedButton(
            child: Text(title),
            onPressed: () {
              Navigator.of(ctx, rootNavigator: true).pop();
              callback();
            },
          ),
        ],
      ),
    );
  }

  Future<void> checkAndGrantBluthoothPermissions() async {
    await polarBloc?.requestPermissions();
    // bluetoothScan / bluetoothConnect are Android-only permissions;
    // on iOS the system Bluetooth consent dialog is handled by the Polar SDK itself.
    if (Platform.isAndroid) {
      if (!await Permission.bluetoothScan.isGranted || !await Permission.bluetoothConnect.isGranted) {
        _showAlertDialog(
            context, context.i18n.bluetoothPermissionText, context.i18n.bluetoothPermissionTitle, context.i18n.cancel, () => openAppSettings());
      }
    }
  }

  Future<bool> isBluethoothOn() async {
    if (await FlutterBluePlus.isSupported == false) {
      return false;
    }
    final state = await FlutterBluePlus.adapterState.first;
    return state == BluetoothAdapterState.on;
  }

  turnOnBluetooth() async {
    if (await isBluethoothOn()) return;
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    } else {
      _showAlertDialog(
          context, context.i18n.bluetoothTurnOnText, context.i18n.bluetoothTurnOnTitle, context.i18n.cancel, () => openAppSettings());
    }
  }
}
