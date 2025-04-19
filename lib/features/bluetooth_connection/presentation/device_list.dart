import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:traguard/features/bluetooth_connection/presentation/device_card.dart';
import 'package:traguard/features/bluetooth_connection/presentation/searching_animation.dart';
import 'package:traguard/utils/sizes.dart';

/// A stateless widget that displays a list of Bluetooth devices.
///
/// This widget takes a list of [ScanResult] objects representing the devices
/// discovered during a Bluetooth scan.
class DeviceList extends StatelessWidget {
  /// Creates a new instance of [DeviceList].
  const DeviceList({required this.devices, super.key});

  /// A list of [ScanResult] objects representing the discovered devices.
  final List<ScanResult> devices;

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) {
      return const SearchingAnimation();
    }

    return ListView.builder(
      itemCount: devices.length,
      padding: Paddings.mediumAll,
      itemBuilder: (_, index) {
        return DeviceCard(device: devices[index]);
      },
    );
  }
}
