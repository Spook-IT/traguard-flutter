import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traguard/utils/assets.dart';
import 'package:traguard/utils/sizes.dart';

/// A widget that displays a message indicating that Bluetooth is turned off.
class BluetoothOff extends StatelessWidget {
  /// Creates a new instance of [BluetoothOff].
  const BluetoothOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Spaces.xLarge,
        children: [
          const Icon(Icons.bluetooth_disabled, size: 100, color: Colors.grey),
          Lottie.asset(
            LottieAssets.switchOnOff.path,
            height: 50,
            frameRate: FrameRate.max,
            fit: BoxFit.cover,
          ),
          const Column(
            spacing: Spaces.tiny,
            children: [
              Text(
                'Bluetooth is turned off.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Please turn on Bluetooth to connect to devices.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
