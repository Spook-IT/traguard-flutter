import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_finder_state.freezed.dart';

/// The state of the Bluetooth screen.
enum BluetoothScreenState {
  /// The Bluetooth screen is in the initial state.
  initial,

  /// The Bluetooth is turned off.
  bluetoothOff,

  /// The Bluetooth is turned on and searching for devices.
  searching,

  /// The Bluetooth is not supported by the device.
  notSupported,
}

/// The state of the Bluetooth finder.
/// This class holds the current state of the Bluetooth screen,
/// including the list of discovered devices.
@freezed
abstract class BluetoothFinderState with _$BluetoothFinderState {
  /// Creates a new instance of [BluetoothFinderState].
  const factory BluetoothFinderState({
    @Default(BluetoothScreenState.initial) BluetoothScreenState screenState,
    @Default([]) List<BluetoothDevice> devices,
  }) = _BluetoothFinderState;
}
