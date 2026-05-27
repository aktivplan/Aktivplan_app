import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';
import '../sensor_repository.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final SensorRepository sensorRepository;

  SensorBloc({
    required this.sensorRepository,
  }) : super(SensorInitial()) {
    on<FetchSensorEvent>((event, emit) async {
      emit(SensorWaitingState());
      List<HealthDataPoint> result = await sensorRepository.fetchData(event.startDate, event.endDate, event.healthDataTypeList);
      final workOutDataList = result.where((x) => x.value is WorkoutHealthValue).toList();
      emit(FetchSensorState(healthDataList: result, healthWorkOutDataList: workOutDataList));
    });

    on<ConnectToGoogleHealthConnectAppleHealthEvent>((event, emit) async {
      var result = await sensorRepository.connectToGoogleHealthConnectAppleHealth(event.healthDataTypeList);
      if (result) await sensorRepository.fetchData(DateTime.now().add(Duration(hours: -1)), DateTime.now(), [HealthDataType.WORKOUT]);
      emit(ConnectToGoogleHealthConnectAppleHealthState());
    });

    on<DisconnectToGoogleHealthConnectAppleHealthEvent>((event, emit) async {
      await sensorRepository.revokePermissions();
      emit(DisconnectToGoogleHealthConnectAppleHealthState());
    });

    on<IsConnectToGoogleHealthConnectAppleHealthEvent>((event, emit) async {
      print("GOOGLE CONNECTED");
      bool isConnected = await sensorRepository.isAuthorizedToGoogleHealthConnectAppleHealth();
      emit(IsConnectToGoogleHealthConnectAppleHealthState(isConnected: isConnected));
    });
  }
}
