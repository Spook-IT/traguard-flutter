import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A screen that displays a list of Bluetooth devices.
class BluetoothListScreen extends ConsumerWidget {
  /// Creates a new instance of [BluetoothListScreen].
  const BluetoothListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth List')),
      body: const Center(child: Text('Bluetooth List Screen')),
    );
  }
}
