import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_actor.dart';
import 'package:traguard/features/bluetooth_connection/presentation/battery_icon.dart';
import 'package:traguard/features/bluetooth_connection/presentation/connect_button.dart';
import 'package:traguard/features/bluetooth_connection/presentation/connection_state_indicator.dart';
import 'package:traguard/utils/assets.dart';
import 'package:traguard/utils/constants.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget represents a card that displays
/// information about a Bluetooth device.
class DeviceCard extends ConsumerStatefulWidget {
  /// Creates a new instance of [DeviceCard].
  const DeviceCard({required this.device, super.key});

  /// The [BluetoothDevice] object representing the Bluetooth device.
  final BluetoothDevice device;

  @override
  ConsumerState<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends ConsumerState<DeviceCard> {
  bool _isConnecting = false;
  late final String _deviceId = widget.device.remoteId.str;

  @override
  void initState() {
    super.initState();

    ref.read(bluetoothActorProvider(deviceId: _deviceId));
  }

  Future<void> _connectToDevice() async {
    if (_isConnecting) {
      return;
    }

    setState(() {
      _isConnecting = true;
    });

    try {
      await ref
          .read(bluetoothActorProvider(deviceId: _deviceId).notifier)
          .setDeviceAndConnect(connectedDevice: widget.device);
    } on Exception catch (e) {
      logger.e('Error connecting to device $_deviceId: $e', error: e);
    } finally {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: Paddings.smallAll,
            child: Image.asset(ImageAssets.trackerDevice.path, height: 100),
          ),
          Expanded(
            child: Padding(
              padding: Paddings.smallAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ConnectionStateIndicator(deviceId: _deviceId),
                      BatteryIcon(deviceId: _deviceId),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.advName,
                        style: context.textTheme.labelLarge,
                      ),
                      Text(_deviceId, style: context.textTheme.labelSmall),
                    ],
                  ),
                  Spaces.medium.sizedBoxHeight,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ConnectDeviceButton(
                      onConnect: _isConnecting ? null : _connectToDevice,
                      onDisconnect: () async {
                        await ref
                            .read(
                              bluetoothActorProvider(
                                deviceId: _deviceId,
                              ).notifier,
                            )
                            .disconnect();
                      },
                      deviceId: _deviceId,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
