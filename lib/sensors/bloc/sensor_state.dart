part of 'sensor_bloc.dart';

abstract class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object> get props => [];
}

class SensorInitial extends SensorState {}

class SensorWaitingState extends SensorState {}

class FetchSensorState extends SensorState {
  final List<HealthDataPoint> healthDataList;
  final List<HealthDataPoint> healthWorkOutDataList;
  FetchSensorState({required this.healthDataList, required this.healthWorkOutDataList});

  @override
  List<Object> get props => [healthDataList, healthWorkOutDataList];
}

class ConnectToGoogleHealthConnectAppleHealthState extends SensorState {
  ConnectToGoogleHealthConnectAppleHealthState();

  @override
  List<Object> get props => [];
}

class DisconnectToGoogleHealthConnectAppleHealthState extends SensorState {
  DisconnectToGoogleHealthConnectAppleHealthState();

  @override
  List<Object> get props => [];
}

class IsConnectToGoogleHealthConnectAppleHealthState extends SensorState {
  final bool isConnected;
  IsConnectToGoogleHealthConnectAppleHealthState({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}
