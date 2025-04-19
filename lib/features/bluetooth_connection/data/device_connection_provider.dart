import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_connection_provider.g.dart';

/// A Riverpod provider that manages the state of a device connection.
@riverpod
class DeviceConnection extends _$DeviceConnection {
  @override
  BluetoothConnectionState build({required String deviceId}) =>
      BluetoothConnectionState.disconnected;

  /// Sets the state of the device connection.
  // ignore: use_setters_to_change_properties
  void setState(BluetoothConnectionState newState) {
    state = newState;
  }
}
