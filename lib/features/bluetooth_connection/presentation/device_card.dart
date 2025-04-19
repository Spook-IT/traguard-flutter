import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_reader.dart';
import 'package:traguard/features/bluetooth_connection/data/device_connection_provider.dart';
import 'package:traguard/utils/assets.dart';
import 'package:traguard/utils/constants.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget represents a card that displays
/// information about a Bluetooth device.
class DeviceCard extends ConsumerStatefulWidget {
  /// Creates a new instance of [DeviceCard].
  const DeviceCard({required this.device, super.key});

  /// The [ScanResult] object representing the Bluetooth device.
  final ScanResult device;

  @override
  ConsumerState<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends ConsumerState<DeviceCard> {
  late final BluetoothDevice _bluetoothDevice = widget.device.device;
  BluetoothReader? _bluetoothReader;

  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();

    ref.listenManual(
      deviceConnectionProvider(deviceId: _bluetoothDevice.remoteId.str),
      (_, _) {},
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO(dariowskii): Implement request battery and gps data call
    });
  }

  Future<void> _connectToDevice() async {
    if (_isConnecting) {
      return;
    }

    setState(() {
      _isConnecting = true;
    });

    final subscription = _bluetoothDevice.connectionState.listen((
      BluetoothConnectionState state,
    ) async {
      if (!mounted) return;

      setState(() {
        _isConnecting = false;
      });

      if (state == BluetoothConnectionState.disconnected) {
        ref
            .read(
              deviceConnectionProvider(
                deviceId: _bluetoothDevice.remoteId.str,
              ).notifier,
            )
            .setState(state);
      } else if (state == BluetoothConnectionState.connected) {
        ref
            .read(
              deviceConnectionProvider(
                deviceId: _bluetoothDevice.remoteId.str,
              ).notifier,
            )
            .setState(state);
        await _discoverServices(_bluetoothDevice);
      }
    });

    _bluetoothDevice.cancelWhenDisconnected(
      subscription,
      delayed: true,
      next: true,
    );

    await _bluetoothDevice.connect();
  }

  Future<void> _discoverServices(BluetoothDevice device) async {
    final services = await device.discoverServices();
    final discoveredService = services.firstOrNull;

    if (discoveredService == null) {
      logger.e('No services found');
      return;
    }

    _bluetoothReader = BluetoothReader(
      connectedDevice: device,
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

    unawaited(_bluetoothReader?.listenNotifications());
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.advertisementData.advName,
                        style: context.textTheme.labelLarge,
                      ),
                      Text(
                        _bluetoothDevice.remoteId.str,
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
