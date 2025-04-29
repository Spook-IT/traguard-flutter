import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget represents a button that allows
/// the user to connect to a Bluetooth device.
class ConnectDeviceButton extends ConsumerWidget {
  /// Creates a new instance of [ConnectDeviceButton].
  const ConnectDeviceButton({
    required this.onConnect,
    required this.onDisconnect,
    required this.deviceId,
    super.key,
  });

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onConnect;

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onDisconnect;

  /// The ID of the Bluetooth device to connect to.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connected = ref.watch(
      connectedDevicesProvider.select(
        (value) =>
            value.devices.any((device) => device.remoteId.str == deviceId),
      ),
    );
    return FilledButton(
      onPressed: connected ? onDisconnect : onConnect,
      style: FilledButton.styleFrom(
        backgroundColor: connected ? Colors.red : null,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      child: Text(connected ? context.l10n.disconnect : context.l10n.connect),
    );
  }
}
