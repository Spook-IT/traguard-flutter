import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_finder.dart';
import 'package:traguard/features/bluetooth_connection/presentation/device_card.dart';
import 'package:traguard/features/bluetooth_connection/presentation/searching_animation.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'package:traguard/shared/utils/extensions.dart' hide DurationExtensions;
import 'package:traguard/shared/utils/sizes.dart';

/// A stateless widget that displays a list of Bluetooth devices.
///
/// This widget takes a list of [ScanResult] objects representing the devices
/// discovered during a Bluetooth scan.
class DeviceList extends ConsumerWidget {
  /// Creates a new instance of [DeviceList].
  const DeviceList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableDevices = ref.watch(bluetoothFinderProvider).devices;
    final connectedDevices = ref.watch(connectedDevicesProvider);
    if (availableDevices.isEmpty && connectedDevices.devices.isEmpty) {
      return const SearchingAnimation();
    }

    final notConnectedDevices =
        availableDevices
            .where((device) => !connectedDevices.devices.contains(device))
            .toList();

    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: Paddings.mediumAll,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notConnectedDevices.isNotEmpty) ...[
              Text(
                context.l10n.availableDevices,
                style: context.textTheme.labelLarge,
              ),
              Spaces.medium.sizedBoxHeight,
              ListView.builder(
                itemCount: notConnectedDevices.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return DeviceCard(device: notConnectedDevices[index])
                      .animate()
                      .fadeIn(duration: 300.ms, delay: (index * 100).ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        duration: 300.ms,
                        delay: (index * 100).ms,
                      );
                },
              ),
            ],
            if (connectedDevices.devices.isNotEmpty &&
                notConnectedDevices.isNotEmpty) ...[
              Spaces.medium.sizedBoxHeight,
            ],
            if (connectedDevices.devices.isNotEmpty) ...[
              Text(
                context.l10n.connectedDevices,
                style: context.textTheme.labelLarge,
              ),
              Spaces.medium.sizedBoxHeight,
              ListView.builder(
                itemCount: connectedDevices.devices.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return DeviceCard(device: connectedDevices.devices[index])
                      .animate()
                      .fadeIn(duration: 300.ms, delay: (index * 100).ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        duration: 300.ms,
                        delay: (index * 100).ms,
                      );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
