import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_finder_state.dart';
import 'package:traguard/utils/constants.dart';
import 'package:traguard/utils/extensions.dart';

part 'bluetooth_finder.g.dart';

/// A Riverpod provider that manages the state of Bluetooth device discovery.
/// It uses the [BluetoothFinderState] class to hold the current state.
@riverpod
class BluetoothFinder extends _$BluetoothFinder {
  StreamSubscription<String>? _logsSubscription;
  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;

  @override
  BluetoothFinderState build() {
    FlutterBluePlus.setLogLevel(LogLevel.info, color: false);
    _logsSubscription = FlutterBluePlus.logs.listen(logger.d);

    ref.onDispose(() {
      _logsSubscription?.cancel();
      _logsSubscription = null;
    });

    ref.onDispose(() {
      _bluetoothStateSubscription?.cancel();
      _bluetoothStateSubscription = null;
    });

    ref.onDispose(() {
      _scanResultsSubscription?.cancel();
      _scanResultsSubscription = null;
    });

    ref.onDispose(FlutterBluePlus.stopScan);

    return const BluetoothFinderState();
  }

  /// Turns on Bluetooth if it is supported by the device.
  /// If Bluetooth is already on, it starts scanning for devices.
  Future<void> turnOnBluetooth() async {
    if (await FlutterBluePlus.isSupported == false) {
      logger.e('Bluetooth not supported by this device');
      state = state.copyWith(screenState: BluetoothScreenState.notSupported);
      return;
    }

    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen((
      BluetoothAdapterState bluetoothState,
    ) {
      logger.i('state: $bluetoothState');
      if (bluetoothState == BluetoothAdapterState.on) {
        _startScan();
        state = state.copyWith(screenState: BluetoothScreenState.searching);
      } else {
        state = state.copyWith(screenState: BluetoothScreenState.bluetoothOff);
      }
    });

    // turn on bluetooth ourself if we can
    // for iOS, the user controls bluetooth enable/disable
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  /*
  * ----------------
  * PRIVATE METHODS
  * ----------------
  */

  Future<void> _startScan() async {
    _scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
      state = state.copyWith(devices: results.map((e) => e.device).toList());
    });

    FlutterBluePlus.cancelWhenScanComplete(_scanResultsSubscription!);

    await FlutterBluePlus.startScan(
      removeIfGone: 5.seconds,
      continuousUpdates: true,
      withKeywords: [r'$ACT'],
    );
  }
}
