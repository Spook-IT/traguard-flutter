import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traguard/shared/utils/assets.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that displays a message indicating that Bluetooth is not supported.
class BluetoothNotSupported extends StatelessWidget {
  /// Creates a new instance of [BluetoothNotSupported].
  const BluetoothNotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Paddings.largeAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spaces.large,
          children: [
            Lottie.asset(
              LottieAssets.error.path,
              frameRate: FrameRate.max,
              height: 100,
            ),
            Text(
              context.l10n.bluetoothNotSupportedOnDevice,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
