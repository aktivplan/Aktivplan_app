import 'package:aptapp/polar/bloc/polar_event.dart';
import 'package:aptapp/polar/bloc/polar_repository.dart';
import 'package:aptapp/polar/bloc/polar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:polar/polar.dart';

class PolarBloc extends Bloc<PolarEvent, PolarState> {
  final PolarRepository polarRepository;
  int attemptConnectCount = 0;
  final maxAttemptConnectCount = 3;
  String _deviceId = "";
  String _potentialIdentifier = "";
  bool isDeviceConnected = false;

  PolarBloc({required this.polarRepository}) : super(PolarInitialState()) {
    on<PolarInitEvent>((event, emit) async {
      attemptConnectCount = 0;

      polarRepository.batteryLevelStream.listen((data) {
        emit(DeviceBatteryLevelState(data.level));
      });

      polarRepository.sdkFeatureReady.listen((data) {
        final polarDevice = PolarDevice(data.identifier, data.identifier, data.identifier, 0, true);
        if (data.feature == PolarSdkFeature.onlineStreaming && data.identifier == _potentialIdentifier) {
          streamWhenReady(polarDevice);
        }
      });

      polarRepository.deviceConnectingStream.listen((data) {
        final polarDevice = PolarDevice(data.deviceId, data.name, data.address, data.rssi, data.isConnectable);
        emit(DeviceConnectingState(polarDevice));
      });

      polarRepository.deviceConnectedStream.listen((data) {
        final polarDevice = PolarDevice(data.deviceId, data.name, data.address, data.rssi, data.isConnectable);
        emit(DeviceConnectedState(polarDevice));
      });

      if (!isDeviceConnected) retryConnectToPolar();

      await emit.forEach(polarRepository.deviceDisconnectedStream, onData: (dynamic data) {
        isDeviceConnected = false;
        final polarDevice = PolarDevice(data?.info?.deviceId, data?.info?.name, data?.info?.address, data?.info?.rssi, data?.info?.isConnectable);
        if (_potentialIdentifier == data?.info?.deviceId) _potentialIdentifier = "";
        return DeviceDisconnectedState(polarDevice);
      }).catchError((error) {
        emit(PolarErrorState(error.toString()));
      });

      emit(PolarInitialState());
    });

    on<PolarBackEvent>((event, emit) async {
      emit(PolarInitialState());
    });

    on<DeviceSearchEvent>((event, emit) async {
      emit(DeviceSearchingState());
      await for (var device in polarRepository.searchForDevicesStream()) {
        final polarDevice = PolarDevice(device.deviceId, device.name, device.address, device.rssi, device.isConnectable);
        emit(DeviceSearchedState(polarDevice));
      }
    });

    on<DeviceConnectEvent>((event, emit) async {
      _potentialIdentifier = event.device.deviceId;
      bool isBonded = await isDeviceBonded(event.device);
      if (isBonded) {
        polarRepository.connectToDevice(event.device.deviceId);
        streamWhenReady(event.device);
      } else {
        polarRepository.connectToDevice(event.device.deviceId);
      }
    });

    on<DeviceDisconnectEvent>((event, emit) async {
      polarRepository.disconnectFromDevice(event.device.deviceId);
      _deviceId = "";
      PolarRepository.setPolarDeviceId(_deviceId);
    });

    on<FetchHeartRateEvent>((event, emit) async {
      await emit.forEach(polarRepository.getHeartRateDataStream(event.device.deviceId), onData: (dynamic data) {
        attemptConnectCount = 0;
        isDeviceConnected = true;
        int hr = data.samples.map((e) => e.hr).toList().first;
        if (_deviceId != event.device.deviceId) {
          _deviceId = event.device.deviceId;
          PolarRepository.setPolarDeviceId(_deviceId);
        }
        return HeartRateDataState(event.device, hr);
      }).catchError((error) {
        if (error.code == 'com.polar.sdk.api.errors.PolarDeviceDisconnected' ||
            error.code == 'com.polar.sdk.api.errors.PolarBleSdkInstanceException' ||
            error.code == 'com.polar.sdk.api.errors.PolarBleSdkInternalException' ||
            error.code == 'com.polar.sdk.api.errors.PolarDeviceNotConnected') {
          attemptConnectCount++;
          if (attemptConnectCount <= maxAttemptConnectCount) {
            add(DeviceConnectEvent(event.device));
          }
          emit(PolarErrorState(error.toString()));
        }
      });
    });
  }

  void retryConnectToPolar() async {
    _deviceId = await PolarRepository.getPolarDeviceId();
    if (_deviceId.isNotEmpty) {
      await polarRepository.disconnectFromDevice(_deviceId);
      final polarDevice = PolarDevice(_deviceId, _deviceId, "", 0, true);
      add(DeviceConnectEvent(polarDevice));
    }
  }

  void streamWhenReady(PolarDevice device) async {
    final availabletypes = await polarRepository.getAvailableOnlineStreamDataTypes(device.deviceId);
    if (availabletypes.contains(PolarDataType.hr)) {
      add(FetchHeartRateEvent(device));
    }
  }

  Future<void> requestPermissions() async {
    await polarRepository.requestPermissions();
  }

  Future<bool> isDeviceBonded(PolarDevice polarDevice) async {
    List<BluetoothDevice> bondedDevices = await FlutterBluePlus.bondedDevices;
    bool isBonded = bondedDevices.any((device) => device.remoteId.str == polarDevice.address);
    return isBonded;
  }

  Future<void> createBond(PolarDevice polarDevice) async {
    await BluetoothDevice.fromId(polarDevice.address).createBond();
  }
}
