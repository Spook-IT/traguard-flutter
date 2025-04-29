import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_actor.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_actor_state.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget represents a GPS icon that can be used to indicate the
/// GPS status of a Bluetooth device.
class GpsIcon extends ConsumerWidget {
  /// Creates a new instance of [GpsIcon].
  const GpsIcon({required this.deviceId, super.key});

  /// The ID of the Bluetooth device.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gpsActive = ref.watch(
      bluetoothActorProvider(deviceId: deviceId).select(
        (value) => switch (value) {
          BluetoothActorStateStart(:final gpsActive) => gpsActive,
          _ => null,
        },
      ),
    );

    return AnimatedCrossFade(
      alignment: Alignment.center,
      firstCurve: Curves.easeIn,
      firstChild: const SizedBox.shrink(),
      crossFadeState:
          gpsActive == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
      secondChild: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: switch (gpsActive) {
            true => Colors.green,
            false => Colors.redAccent.shade100,
            null => Colors.grey,
          },
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          switch (gpsActive) {
            true => Icons.gps_fixed,
            _ => Icons.gps_not_fixed,
          },
          size: 16,
          color: Colors.white,
        ),
      ),
      duration: 300.ms,
    );
  }
}
