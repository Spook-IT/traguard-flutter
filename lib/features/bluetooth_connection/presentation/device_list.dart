import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_reader.dart';
import 'package:traguard/features/bluetooth_connection/presentation/searching_animation.dart';
import 'package:traguard/utils/constants.dart';

/// A stateless widget that displays a list of Bluetooth devices.
///
/// This widget takes a list of [ScanResult] objects representing the devices
/// discovered during a Bluetooth scan.
class DeviceList extends StatefulWidget {
  /// Creates a new instance of [DeviceList].
  const DeviceList({required this.devices, super.key});

  /// A list of [ScanResult] objects representing the discovered devices.
  final List<ScanResult> devices;

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  BluetoothReader? _bluetoothReader;

  Future<void> _connectToDevice(BluetoothDevice device) async {
    final subscription = device.connectionState.listen((
      BluetoothConnectionState state,
    ) async {
      if (state == BluetoothConnectionState.disconnected) {
        logger.t('${device.disconnectReason?.description}');
      } else if (state == BluetoothConnectionState.connected) {
        logger.t('Connected to ${device.advName}');
        await _discoverServices(device);
      }
    });
    device.cancelWhenDisconnected(subscription, delayed: true, next: true);

    await device.connect();
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
    if (widget.devices.isEmpty) {
      return const SearchingAnimation();
    }

    return ListView.builder(
      itemCount: widget.devices.length,
      itemBuilder: (_, index) {
        final device = widget.devices[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(device.advertisementData.advName),
                subtitle: Text(device.device.remoteId.str),
                onTap: () => _connectToDevice(device.device),
              ),
              const Divider(),
              FilledButton(
                onPressed: () => _bluetoothReader?.requestBatteryAndGps(),
                child: const Text('Request battery'),
              ),
              FilledButton(
                onPressed: () => _bluetoothReader?.requestBrief(),
                child: const Text('Request brief'),
              ),
              FilledButton(
                onPressed: () => _bluetoothReader?.requestGpsDatas(),
                child: const Text('Request GPS data'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('RSSI: ${device.rssi}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
