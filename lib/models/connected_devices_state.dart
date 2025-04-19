import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connected_devices_state.freezed.dart';

/// This class represents the state of connected devices list.
@freezed
abstract class ConnectedDevicesState with _$ConnectedDevicesState {
  /// Creates a new instance of [ConnectedDevicesState].
  const factory ConnectedDevicesState({
    @Default([]) List<BluetoothDevice> devices,
  }) = _ConnectedDevicesState;
}
