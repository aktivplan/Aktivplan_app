import 'package:aptapp/polar/bloc/polar_repository.dart';
import 'package:equatable/equatable.dart';

abstract class PolarState extends Equatable {
  @override
  List<Object> get props => [];
}

class PolarInitialState extends PolarState {}

class DeviceSearchingState extends PolarState {}

class DeviceSearchedState extends PolarState {
  final PolarDevice device;

  DeviceSearchedState(this.device);

  @override
  List<Object> get props => [device];
}

class DeviceBatteryLevelState extends PolarState {
  final int level;

  DeviceBatteryLevelState(this.level);

  @override
  List<Object> get props => [level];
}

class DeviceConnectingState extends PolarState {
  final PolarDevice device;

  DeviceConnectingState(this.device);

  @override
  List<Object> get props => [device];
}

class DeviceConnectedState extends PolarState {
  final PolarDevice device;

  DeviceConnectedState(this.device);

  @override
  List<Object> get props => [device];
}

class DeviceDisconnectedState extends PolarState {
  final PolarDevice device;

  DeviceDisconnectedState(this.device);

  @override
  List<Object> get props => [device];
}

class HeartRateDataState extends PolarState {
  final PolarDevice device;
  final int heartRate;

  HeartRateDataState(this.device, this.heartRate);
  @override
  List<Object> get props => [device, heartRate];
}

class PolarErrorState extends PolarState {
  final String message;

  PolarErrorState(this.message);

  @override
  List<Object> get props => [message];
}
