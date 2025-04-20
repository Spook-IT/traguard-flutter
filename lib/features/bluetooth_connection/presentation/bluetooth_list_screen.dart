import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/bluetooth_connection/presentation/bluetooth_off.dart';
import 'package:traguard/features/bluetooth_connection/presentation/device_list.dart';
import 'package:traguard/utils/constants.dart';
import 'package:traguard/utils/extensions.dart';

/// The state of the Bluetooth screen.
enum BluetoothScreenState {
  /// The Bluetooth screen is in the initial state.
  initial,

  /// The Bluetooth is turned off.
  bluetoothOff,

  /// The Bluetooth is turned on and searching for devices.
  searching,

  /// The Bluetooth has an error.
  error,
}

/// A screen that displays a list of Bluetooth devices.
class BluetoothListScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [BluetoothListScreen].
  const BluetoothListScreen({super.key});

  @override
  ConsumerState<BluetoothListScreen> createState() =>
      _BluetoothListScreenState();
}

class _BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  late StreamSubscription<String> _logsSubscription;
  late StreamSubscription<BluetoothAdapterState> _bluetoothStateSubscription;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;

  late List<BluetoothDevice> _scanResults = [];

  /// The current state of the Bluetooth screen.
  BluetoothScreenState _bluetoothScreenState = BluetoothScreenState.initial;

  @override
  void initState() {
    super.initState();

    FlutterBluePlus.setLogLevel(LogLevel.info, color: false);
    // optional
    FlutterBluePlus.logs.listen(logger.d);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _turnOnBluetooth();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _logsSubscription.cancel();
    _bluetoothStateSubscription.cancel();
    _scanResultsSubscription.cancel();
  }

  Future<void> _turnOnBluetooth() async {
    if (await FlutterBluePlus.isSupported == false) {
      logger.e('Bluetooth not supported by this device');
      setState(() {
        _bluetoothScreenState = BluetoothScreenState.error;
      });
      return;
    }

    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen((
      BluetoothAdapterState state,
    ) {
      logger.i('state: $state');
      if (state == BluetoothAdapterState.on) {
        _startScan();
        setState(() {
          _bluetoothScreenState = BluetoothScreenState.searching;
        });
      } else {
        setState(() {
          _bluetoothScreenState = BluetoothScreenState.bluetoothOff;
        });
      }
    });

    // turn on bluetooth ourself if we can
    // for iOS, the user controls bluetooth enable/disable
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  Future<void> _startScan() async {
    _scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
      if (!mounted) return;
      setState(() {
        _scanResults = results.map((e) => e.device).toList();
      });
    });

    FlutterBluePlus.cancelWhenScanComplete(_scanResultsSubscription);

    await FlutterBluePlus.startScan(
      removeIfGone: 5.seconds,
      continuousUpdates: true,
      withKeywords: [r'$ACT'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = switch (_bluetoothScreenState) {
      BluetoothScreenState.bluetoothOff => const BluetoothOff(),
      BluetoothScreenState.initial ||
      BluetoothScreenState.searching => DeviceList(devices: _scanResults),
      BluetoothScreenState.error => const Center(
        child: Text('An error occurred.'),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth List')),
      body: SafeArea(child: child),
    );
  }
}
