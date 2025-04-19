import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traguard/features/bluetooth_connection/domain/brief_data.dart';

part 'bluetooth_actor_state.freezed.dart';

/// A class that represents a Bluetooth reader.
/// It contains a list of Bluetooth services that can be used to
/// communicate with Bluetooth devices.
@freezed
sealed class BluetoothActorState with _$BluetoothActorState {
  /// Creates a new instance of [BluetoothActorState].
  /// This is used when the Bluetooth reader is not initialized.
  const factory BluetoothActorState.empty() = BluetoothActorStateEmpty;

  /// Creates a new instance of [BluetoothActorState].
  /// This is used when the Bluetooth reader is initialized.
  const factory BluetoothActorState.start({
    /// The Bluetooth device that is connected.
    required BluetoothDevice connectedDevice,

    /// A list of Bluetooth services.
    required BluetoothService service,

    /// The characteristic used for reading notifications.
    required BluetoothCharacteristic notifyCaracteristic,

    /// The characteristic used for writing data.
    /// This is used to send commands to the Bluetooth device.
    required BluetoothCharacteristic writeCaracteristic,

    /// The battery level of the Bluetooth device.
    @Default(0) double batteryLevel,

    /// The GPS state of the Bluetooth device.
    @Default(false) bool gpsActive,

    /// The device brief list
    @Default([]) List<BriefData> fileList,
  }) = BluetoothActorStateStart;
}
