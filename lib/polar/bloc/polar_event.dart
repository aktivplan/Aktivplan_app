import 'package:aptapp/polar/bloc/polar_repository.dart';
import 'package:equatable/equatable.dart';

abstract class PolarEvent extends Equatable {
  const PolarEvent();

  @override
  List<Object> get props => [];
}

class PolarInitEvent extends PolarEvent {}

class PolarBackEvent extends PolarEvent {}

class DeviceSearchEvent extends PolarEvent {}

class DeviceConnectEvent extends PolarEvent {
  final PolarDevice device;

  DeviceConnectEvent(this.device);

  @override
  List<Object> get props => [device];
}

class DeviceDisconnectEvent extends PolarEvent {
  final PolarDevice device;

  DeviceDisconnectEvent(this.device);

  @override
  List<Object> get props => [device];
}

class FetchHeartRateEvent extends PolarEvent {
  final PolarDevice device;
  FetchHeartRateEvent(this.device);

  @override
  List<Object> get props => [device];
}
