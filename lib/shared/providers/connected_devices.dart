import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/shared/models/connected_devices_state.dart';

part 'connected_devices.g.dart';

/// A Riverpod provider that manages the state of connected devices.
@riverpod
class ConnectedDevices extends _$ConnectedDevices {
  @override
  ConnectedDevicesState build() => const ConnectedDevicesState();

  /// Adds a device to the list of connected devices.
  void addDevice(BluetoothDevice device) {
    if (state.devices.any((d) => d.remoteId == device.remoteId)) {
      return;
    }
    state = state.copyWith(devices: [...state.devices, device]);
  }

  /// Removes a device from the list of connected devices.
  void removeDevice(BluetoothDevice device) {
    state = state.copyWith(
      devices:
          state.devices.where((d) => d.remoteId != device.remoteId).toList(),
    );
  }
}
