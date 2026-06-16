import 'dart:async';
import 'package:polar/polar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PolarRepository {
  PolarRepository._();
  factory PolarRepository() => _instance;
  static final PolarRepository _instance = PolarRepository._();

  final Polar _polar = Polar();

  Stream<PolarDeviceInfo> searchForDevicesStream() {
    return _polar.searchForDevice();
  }

  Future<void> connectToDevice(String deviceId) {
    return _polar.connectToDevice(deviceId);
  }

  Stream<PolarBatteryLevelEvent> get batteryLevelStream => _polar.batteryLevel;
  Stream<PolarDeviceInfo> get deviceConnectingStream => _polar.deviceConnecting;
  Stream<PolarDeviceInfo> get deviceConnectedStream => _polar.deviceConnected;
  Stream<PolarDeviceDisconnectedEvent> get deviceDisconnectedStream => _polar.deviceDisconnected;
  Stream<PolarSdkFeatureReadyEvent> get sdkFeatureReady => _polar.sdkFeatureReady;

  Future<void> disconnectFromDevice(String deviceId) async {
    return await _polar.disconnectFromDevice(deviceId);
  }

  Stream<PolarHrData> getHeartRateDataStream(String identifier) {
    return _polar.startHrStreaming(identifier);
  }

  Future<Set<PolarDataType>> getAvailableOnlineStreamDataTypes(
    String identifier,
  ) async {
    return _polar.getAvailableOnlineStreamDataTypes(identifier);
  }

  Future<PolarSdkFeatureReadyEvent> checkPolarSdkFeatureReady(String deviceId) async {
    return await _polar.sdkFeatureReady.firstWhere(
      (e) => e.identifier == deviceId && e.feature == PolarSdkFeature.onlineStreaming,
    );
  }

  static Future<String> getPolarDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("polarDeviceId")) {
      return prefs.getString("polarDeviceId")!;
    }
    return "";
  }

  static Future<void> setPolarDeviceId(String polarDeviceId) async {
    final prefs = await SharedPreferences.getInstance();
    if (polarDeviceId.isNotEmpty) {
      await prefs.setString("polarDeviceId", polarDeviceId);
    } else {
      await prefs.remove("polarDeviceId");
    }
  }

  Future<void> requestPermissions() async {
    await _polar.requestPermissions();
  }
}

class PolarDevice {
  final String deviceId;
  final String address;
  final int rssi;
  final String name;
  final bool isConnectable;

  PolarDevice(this.deviceId, this.name, this.address, this.rssi, this.isConnectable);

  @override
  bool operator ==(other) {
    return (other is PolarDevice) && (other.deviceId == deviceId && other.address == address);
  }

  @override
  int get hashCode => deviceId.hashCode ^ address.hashCode;
}
