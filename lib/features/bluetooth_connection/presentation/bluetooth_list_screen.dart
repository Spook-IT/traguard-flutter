import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/data/bluetooth_finder.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_finder_state.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_not_supported.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_off.dart';
import 'package:traguard/features/bluetooth_connection/presentation/device_list.dart';
import 'package:traguard/utils/extensions.dart';

/// A screen that displays a list of Bluetooth devices.
class BluetoothListScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [BluetoothListScreen].
  const BluetoothListScreen({super.key});

  @override
  ConsumerState<BluetoothListScreen> createState() =>
      _BluetoothListScreenState();
}

class _BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bluetoothFinderProvider.notifier).turnOnBluetooth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothFinderState = ref.watch(bluetoothFinderProvider).screenState;
    final child = switch (bluetoothFinderState) {
      BluetoothScreenState.bluetoothOff => const BluetoothOff(),
      BluetoothScreenState.initial ||
      BluetoothScreenState.searching => const DeviceList(),
      BluetoothScreenState.notSupported => const BluetoothNotSupported(),
    };

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.bluetoothDeviceList)),
      body: SafeArea(child: child),
    );
  }
}
