part of 'sensor_bloc.dart';

abstract class SensorEvent extends Equatable {
  const SensorEvent();

  @override
  List<Object> get props => [];
}

class FetchSensorEvent extends SensorEvent {
  final DateTime startDate;
  final DateTime endDate;
  final List<HealthDataType> healthDataTypeList;

  FetchSensorEvent({
    required this.startDate,
    required this.endDate,
    required this.healthDataTypeList,
  });

  @override
  List<Object> get props => [startDate, endDate, healthDataTypeList];
}

class ConnectToGoogleHealthConnectAppleHealthEvent extends SensorEvent {
  final List<HealthDataType> healthDataTypeList;
  ConnectToGoogleHealthConnectAppleHealthEvent({required this.healthDataTypeList});

  @override
  List<Object> get props => [healthDataTypeList];
}

class DisconnectToGoogleHealthConnectAppleHealthEvent extends SensorEvent {
  DisconnectToGoogleHealthConnectAppleHealthEvent();

  @override
  List<Object> get props => [];
}

class IsConnectToGoogleHealthConnectAppleHealthEvent extends SensorEvent {
  IsConnectToGoogleHealthConnectAppleHealthEvent();

  @override
  List<Object> get props => [];
}
