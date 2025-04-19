import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/device_connection_provider.dart';

/// Widget that displays the connection state of a Bluetooth device.
class ConnectionStateIndicator extends ConsumerWidget {
  /// Creates a new instance of [ConnectionStateIndicator].
  const ConnectionStateIndicator({required this.deviceId, super.key});

  /// The ID of the Bluetooth device.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deviceConnectionProvider(deviceId: deviceId));
    return switch (state) {
      BluetoothConnectionState.connected => const Icon(
        Icons.bluetooth_connected,
        color: Colors.green,
        size: 16,
      ),
      BluetoothConnectionState.disconnected => const Icon(
        Icons.bluetooth_disabled,
        color: Colors.red,
        size: 16,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
