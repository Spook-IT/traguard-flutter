import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_actor.dart';
import 'package:traguard/features/bluetooth_connection/presentation/connection_state_indicator.dart';
import 'package:traguard/providers/connected_devices.dart';
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

  @override
  void initState() {
    super.initState();

    ref.listenManual(
      bluetoothActorProvider(deviceId: widget.device.remoteId.str),
      (_, _) {},
    );
  }

  Future<void> _connectToDevice() async {
    if (_isConnecting) {
      return;
    }

    setState(() {
      _isConnecting = true;
    });

    final subscription = widget.device.connectionState.listen((
      BluetoothConnectionState state,
    ) async {
      if (!mounted) return;

      setState(() {
        _isConnecting = false;
      });

      if (state == BluetoothConnectionState.disconnected) {
        ref.read(connectedDevicesProvider.notifier).removeDevice(widget.device);
      } else if (state == BluetoothConnectionState.connected) {
        ref.read(connectedDevicesProvider.notifier).addDevice(widget.device);
        await _discoverServices();
      }
    });

    widget.device.cancelWhenDisconnected(subscription, next: true);
    await widget.device.connect();
  }

  Future<void> _discoverServices() async {
    final services = await widget.device.discoverServices();
    final discoveredService = services.firstOrNull;

    if (discoveredService == null) {
      logger.e('No services found');
      return;
    }

    ref
        .read(
          bluetoothActorProvider(deviceId: widget.device.remoteId.str).notifier,
        )
        .setupActor(
          connectedDevice: widget.device,
          service: discoveredService,
          notifyCaracteristic: discoveredService.characteristics.firstWhere(
            (element) => element.properties.notify == true,
            orElse: () => throw Exception('No notify characteristic found'),
          ),
          writeCaracteristic: discoveredService.characteristics.firstWhere(
            (element) => element.properties.write == true,
            orElse: () => throw Exception('No write characteristic found'),
          ),
        );
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
                  Align(
                    alignment: Alignment.topRight,
                    child: ConnectionStateIndicator(
                      deviceId: widget.device.remoteId.str,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.advName,
                        style: context.textTheme.labelLarge,
                      ),
                      Text(
                        widget.device.remoteId.str,
                        style: context.textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Spaces.medium.sizedBoxHeight,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      onPressed: _isConnecting ? null : _connectToDevice,
                      child: const Text('Connect'),
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
