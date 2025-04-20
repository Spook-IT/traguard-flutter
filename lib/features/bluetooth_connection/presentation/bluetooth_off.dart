import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traguard/utils/assets.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// A widget that displays a message indicating that Bluetooth is turned off.
class BluetoothOff extends StatelessWidget {
  /// Creates a new instance of [BluetoothOff].
  const BluetoothOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Paddings.largeAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spaces.xLarge,
          children: [
            const Icon(Icons.bluetooth_disabled, size: 100, color: Colors.grey),
            Lottie.asset(
              LottieAssets.switchOnOff.path,
              height: 40,
              frameRate: FrameRate.max,
            ),
            Column(
              spacing: Spaces.tiny,
              children: [
                Text(
                  context.l10n.bluetoothOff,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.l10n.pleaseTurnOnBluetooth,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
