import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/bluetooth_connection/domain/bluetooth_actor_state.dart';
import 'package:traguard/features/bluetooth_connection/domain/brief_data.dart';
import 'package:traguard/features/bluetooth_connection/domain/gps_data.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'package:traguard/shared/utils/constants.dart';
import 'package:traguard/shared/utils/extensions.dart';

part 'bluetooth_actor.g.dart';

/// An enum that represents the different Bluetooth services.
enum BluetoothCommands {
  /// Command to request the battery level.
  batteryAndGps,

  /// Command to check the brief.
  checkBrief,

  /// Command to get the GPS data.
  getGpsData;

  /// Converts the command to a list of bytes.
  List<int> getBytes({int briefId = 0}) {
    switch (this) {
      case BluetoothCommands.batteryAndGps:
        return [0x20];
      case BluetoothCommands.checkBrief:
        return [0x30];
      case BluetoothCommands.getGpsData:
        return [0x32, briefId & 0xff, (briefId >> 8) & 0xff];
    }
  }

  /// The first byte of the response for the command.
  int get firstResponseByte => switch (this) {
    BluetoothCommands.batteryAndGps => 0x21,
    BluetoothCommands.checkBrief => 0x31,
    BluetoothCommands.getGpsData => 0x33,
  };
}

/// A Riverpod provider for the [BluetoothActorState] class.
/// It provides a way to manage the state of the Bluetooth reader
/// and allows for easy access to the Bluetooth device and its services.
@Riverpod(keepAlive: true)
class BluetoothActor extends _$BluetoothActor {
  StreamSubscription<List<int>>? _notificationSubscription;
  int _requestedBriefId = -1;

  Timer? _timerRequestBatteryAndGps;

  @override
  BluetoothActorState build({required String deviceId}) {
    _listenDeviceConnection();

    ref.onDispose(() {
      _notificationSubscription?.cancel();
      _notificationSubscription = null;
    });

    ref.onDispose(() {
      _timerRequestBatteryAndGps?.cancel();
      _timerRequestBatteryAndGps = null;
    });

    return const BluetoothActorState.empty();
  }

  /// Set the connected Bluetooth device.
  Future<void> setDeviceAndConnect({
    required BluetoothDevice connectedDevice,
  }) async {
    state = BluetoothActorState.device(connectedDevice: connectedDevice);

    final subscription = connectedDevice.connectionState.listen((
      BluetoothConnectionState connectionState,
    ) async {
      if (connectionState == BluetoothConnectionState.disconnected) {
        ref
            .read(connectedDevicesProvider.notifier)
            .removeDevice(connectedDevice);
      } else if (connectionState == BluetoothConnectionState.connected) {
        ref.read(connectedDevicesProvider.notifier).addDevice(connectedDevice);
        await _discoverServices();
      }
    });

    connectedDevice.cancelWhenDisconnected(
      subscription,
      next: true,
      delayed: true,
    );
    await connectedDevice.connect();
  }

  /// Disconnects the Bluetooth device.
  Future<void> disconnect() async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    if (state is BluetoothActorStateOnlyDevice) {
      logger.e('BluetoothActorState is only device');
      return;
    }

    final started = state as BluetoothActorStateStart;

    try {
      await started.connectedDevice.disconnect();
      state = const BluetoothActorState.empty();
    } on Exception catch (e) {
      logger.e('Error disconnecting: $e');
    }
  }

  /// Listens for notifications from the Bluetooth device.
  Future<void> listenNotifications() async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    final started = state as BluetoothActorStateStart;
    final valueStream = started.notifyCaracteristic.onValueReceived;
    _notificationSubscription = valueStream.listen((value) {
      if (value.isEmpty) {
        logger.e('Received empty notification');
        return;
      }
      _handleNotification(value);
    });

    if (_notificationSubscription == null) {
      logger.e('Notification subscription is null');
      return;
    }

    try {
      started.connectedDevice.cancelWhenDisconnected(
        _notificationSubscription!,
      );
      await started.notifyCaracteristic.setNotifyValue(true);
    } on Exception catch (e) {
      logger.e('Error setting notification: $e');
      await _notificationSubscription?.cancel();
    }
  }

  /// Requests the battery level and GPS state from the Bluetooth device.
  Future<void> requestBatteryAndGps() async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }
    final started = state as BluetoothActorStateStart;

    try {
      await started.writeCaracteristic.write(
        BluetoothCommands.batteryAndGps.getBytes(),
      );
    } on Exception catch (e) {
      logger.e('Error writing to characteristic: $e');
    }
  }

  /// Requests the briefs from the Bluetooth device.
  Future<void> requestBriefs() async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    final started = state as BluetoothActorStateStart;

    if (started.fileList.isNotEmpty) {
      state = started.copyWith(fileList: []);
    }

    try {
      await started.writeCaracteristic.write(
        BluetoothCommands.checkBrief.getBytes(),
      );
    } on Exception catch (e) {
      logger.e('Error writing to characteristic: $e');
    }
  }

  /// Requests the GPS data for each brief in the file list.
  Future<void> requestGpsDatas({required int briefId}) async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }
    final started = state as BluetoothActorStateStart;
    if (started.fileList.isEmpty) {
      logger.e('No brief found');
      return;
    }

    try {
      final brief = started.fileList.firstWhere(
        (element) => element.id == briefId,
      );
      _requestedBriefId = briefId;
      await started.writeCaracteristic.write(
        BluetoothCommands.getGpsData.getBytes(briefId: brief.id),
      );
    } on Exception catch (e) {
      logger.e('Error writing to characteristic: $e');
      _requestedBriefId = -1;
    }
  }

  /*
  * ----------------
  * PRIVATE METHODS
  * ----------------
  */

  void _setupTimerRequestBatteryAndGps({
    Duration timerDuration = const Duration(seconds: 5),
  }) {
    _timerRequestBatteryAndGps?.cancel();
    _timerRequestBatteryAndGps = Timer.periodic(timerDuration, (timer) async {
      if (state is BluetoothActorStateEmpty ||
          state is BluetoothActorStateOnlyDevice) {
        logger.e('BluetoothActorState is empty or only device');
        timer.cancel();
        return;
      }

      final started = state as BluetoothActorStateStart;
      if (started.gpsActive && timerDuration.inSeconds < 10) {
        _setupTimerRequestBatteryAndGps(timerDuration: 10.seconds);
        return;
      }

      if (!started.gpsActive && timerDuration.inSeconds > 5) {
        _setupTimerRequestBatteryAndGps();
        return;
      }

      unawaited(requestBatteryAndGps());
    });
  }

  Future<void> _discoverServices() async {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    if (state is BluetoothActorStateStart) {
      logger.e('BluetoothActorState is already started');
      return;
    }

    final onlyDevice = state as BluetoothActorStateOnlyDevice;
    final connectedDevice = onlyDevice.connectedDevice;

    final services = await connectedDevice.discoverServices();
    final discoveredService = services.firstOrNull;

    if (discoveredService == null) {
      logger.e('No services found');
      return;
    }

    state = BluetoothActorState.start(
      connectedDevice: connectedDevice,
      service: discoveredService,
      notifyCaracteristic: discoveredService.characteristics.firstWhere(
        (element) => element.properties.notify == true,
        orElse: () => throw Exception('No notify characteristic found'),
      ),
      writeCaracteristic: discoveredService.characteristics.firstWhere(
        (element) => element.properties.write == true,
        orElse: () => throw Exception('No write characteristic found'),
      ),
    );
  }

  void _listenDeviceConnection() {
    ref.listen(
      connectedDevicesProvider.select(
        (value) =>
            value.devices
                .where((device) => device.remoteId.str == deviceId)
                .firstOrNull,
      ),
      (_, next) {
        final isConnected = next?.isConnected ?? false;
        if (!isConnected) {
          state = const BluetoothActorState.empty();
        }
      },
    );

    listenSelf((prev, next) async {
      if (prev is BluetoothActorStateOnlyDevice &&
          next is BluetoothActorStateStart) {
        await listenNotifications();
        await requestBatteryAndGps();
        _setupTimerRequestBatteryAndGps();
      }
    });
  }

  void _handleNotification(List<int> data) {
    final firstByte = data.first;

    if (firstByte == BluetoothCommands.batteryAndGps.firstResponseByte) {
      _analyzeBatteryAndGpsData(data);
      return;
    }

    if (firstByte == BluetoothCommands.checkBrief.firstResponseByte) {
      _analyzeBrief(data);
      return;
    }

    if (firstByte == BluetoothCommands.getGpsData.firstResponseByte) {
      _analyzeGpsData(data);
      return;
    }

    logger.e('Unknown notification: ${data.join(', ')}');
  }

  void _analyzeBatteryAndGpsData(List<int> data) {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    final started = state as BluetoothActorStateStart;

    var batteryLevel = (data[2] | (data[3] << 8)) / 100;
    final gpsActive = data[4] & 0x01 == 1;

    const batteryMax = 4.10;
    const batteryMin = 3.6;

    batteryLevel =
        (batteryLevel - batteryMin) / (batteryMax - batteryMin) * 100;

    batteryLevel = batteryLevel.clamp(0, 100);

    logger
      ..d('Battery level: ${batteryLevel.toStringAsFixed(0)} %')
      ..d('GPS state: $gpsActive');

    state = started.copyWith(batteryLevel: batteryLevel, gpsActive: gpsActive);
  }

  void _analyzeBrief(List<int> data) {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    final started = state as BluetoothActorStateStart;
    final fileList = [...started.fileList];

    var index = 1;
    final year = DateTime.now().year % 100;

    while (index < data.length) {
      final length = data[index + 16] | (data[index + 17] << 8);
      if (length == 0) {
        break;
      }
      final startDate =
          (data[index] |
              (data[index + 1] << 8) |
              (data[index + 2] << 16) |
              (data[index + 3] << 24)) +
          year * 10000;
      final startTime =
          data[index + 4] |
          (data[index + 5] << 8) |
          (data[index + 6] << 16) |
          (data[index + 7] << 24);
      final endDate =
          (data[index + 8] |
              (data[index + 9] << 8) |
              (data[index + 10] << 16) |
              (data[index + 11] << 24)) +
          year * 10000;
      final endTime =
          data[index + 12] |
          (data[index + 13] << 8) |
          (data[index + 14] << 16) |
          (data[index + 15] << 24);
      final id = data[index + 18] | (data[index + 19] << 8);

      var state = BriefState.ready;
      if (data[index + 20] == 2) {
        state = BriefState.end;
      } else if (data[index + 20] == 1) {
        state = BriefState.recording;
      }

      fileList.add(
        BriefData(
          startDate: startDate,
          startTime: startTime,
          endDate: endDate,
          endTime: endTime,
          length: length,
          id: id,
          state: state,
          duration: Duration(milliseconds: endTime - startTime),
          startDateTime: _decodeDate(date: startDate, time: startTime),
          endDateTime: _decodeDate(date: endDate, time: endTime),
        ),
      );

      index += 21;
    }

    logger.d(fileList);

    state = started.copyWith(fileList: fileList);
  }

  void _analyzeGpsData(List<int> data) {
    if (state is BluetoothActorStateEmpty) {
      logger.e('BluetoothActorState is empty');
      return;
    }

    final started = state as BluetoothActorStateStart;

    if (_requestedBriefId == -1) {
      logger.e('No brief requested');
      return;
    }

    final brief = started.fileList.firstWhere(
      (element) => element.id == _requestedBriefId,
    );
    var p = (data[1] + 1 + data[2] * 256) * 14 / brief.length;
    if (p > 1) p = 1;

    final downloadProgress = p * 100;

    var gps = <GpsData>[];
    if (data[1] != 0) {
      gps = List.from(brief.gpsData);
    }

    var n = 3;
    while (n < data.length) {
      final time =
          data[n] |
          (data[n + 1] << 8) |
          (data[n + 2] << 16) |
          (data[n + 3] << 24);
      if (time == -1) break;

      final latitude =
          (data[n + 4] |
              (data[n + 5] << 8) |
              (data[n + 6] << 16) |
              (data[n + 7] << 24)) /
          6000000;
      final longitude =
          (data[n + 8] |
              (data[n + 9] << 8) |
              (data[n + 10] << 16) |
              (data[n + 11] << 24)) /
          6000000;

      gps.add(
        GpsData(
          time: time,
          latitude: latitude.toStringAsFixed(6),
          longitude: longitude.toStringAsFixed(6),
        ),
      );

      n += 12;
    }

    final newBrief = brief.copyWith(
      gpsData: [
        ...{...gps},
      ],
    );
    final newBriefList =
        [
          ...started.fileList,
        ].map((e) => e.id == newBrief.id ? newBrief : e).toList();

    state = started.copyWith(fileList: newBriefList);

    logger
      ..d('GPS data: ${jsonEncode(gps.map((e) => e.toJson()).toList())}')
      ..d('GPS data length: ${gps.length}')
      ..d('Process percentage: ${downloadProgress.toStringAsFixed(0)} %');
  }

  DateTime? _decodeDate({required int date, required int time}) {
    final day = (date % 10000) ~/ 100;
    final month = date % 100;
    final year = date ~/ 10000 + 2000;

    if (month > 12) return null;
    if (day > 31) return null;

    final hour = time ~/ 3600000;
    final min = (time - hour * 3600 * 1000) ~/ 60000;
    final s = (time - hour * 3600 * 1000 - min * 60000) ~/ 1000;

    final monthS = '$month'.padLeft(2, '0');
    final dayS = '$day'.padLeft(2, '0');
    final hourS = '$hour'.padLeft(2, '0');
    final minS = '$min'.padLeft(2, '0');
    final secS = '$s'.padLeft(2, '0');

    final iso8601 = '$year-$monthS-${dayS}T$hourS:$minS:$secS.000Z';

    return DateTime.tryParse(iso8601)?.toLocal();
  }
}
