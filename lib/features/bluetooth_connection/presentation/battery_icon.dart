import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_actor.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_actor_state.dart';

/// Widget that displays the battery level of a Bluetooth device.
class BatteryIcon extends ConsumerWidget {
  /// Creates a new instance of [BatteryIcon].
  const BatteryIcon({required this.deviceId, super.key});

  /// The ID of the Bluetooth device.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel = ref.watch(
      bluetoothActorProvider(deviceId: deviceId).select(
        (value) => switch (value) {
          BluetoothActorStateStart(:final batteryLevel) => batteryLevel,
          _ => null,
        },
      ),
    );
    if (batteryLevel == null || batteryLevel < 0) {
      return const SizedBox.shrink();
    }

    if (batteryLevel > 80) {
      return const Icon(Icons.battery_full, size: 16, color: Colors.green);
    } else if (batteryLevel > 50) {
      return const Icon(Icons.battery_3_bar, size: 16, color: Colors.yellow);
    } else if (batteryLevel > 25) {
      return const Icon(Icons.battery_2_bar, size: 16, color: Colors.orange);
    } else if (batteryLevel > 0) {
      return const Icon(Icons.battery_1_bar, size: 16, color: Colors.red);
    }

    return const Icon(Icons.battery_0_bar, size: 16, color: Colors.red);
  }
}
