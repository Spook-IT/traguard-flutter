import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/providers/connected_devices.dart';

/// Widget that displays the connection state of a Bluetooth device.
class ConnectionStateIndicator extends ConsumerWidget {
  /// Creates a new instance of [ConnectionStateIndicator].
  const ConnectionStateIndicator({required this.deviceId, super.key});

  /// The ID of the Bluetooth device.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connected = ref.watch(
      connectedDevicesProvider.select(
        (value) =>
            value.devices.any((device) => device.remoteId.str == deviceId),
      ),
    );

    return Icon(
      connected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
      color: connected ? Colors.green : Colors.red,
      size: 16,
    );
  }
}
