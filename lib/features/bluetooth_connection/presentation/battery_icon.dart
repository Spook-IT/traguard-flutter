import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_actor.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_actor_state.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

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

    final iconData = switch (batteryLevel) {
      > 100 => Icons.battery_full,
      > 80 => Icons.battery_6_bar,
      > 60 => Icons.battery_5_bar,
      > 40 => Icons.battery_4_bar,
      > 20 => Icons.battery_3_bar,
      > 0 => Icons.battery_2_bar,
      _ => Icons.battery_0_bar,
    };

    final color = switch (batteryLevel) {
      > 60 => Colors.green,
      > 40 => Colors.yellow,
      > 20 => Colors.orange,
      > 0 => Colors.red,
      _ => Colors.red,
    };

    return Container(
      padding: Paddings.tinyAll,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(iconData, color: Colors.white, size: 16),
          Text(
            '${batteryLevel.toStringAsFixed(0)}%',
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
