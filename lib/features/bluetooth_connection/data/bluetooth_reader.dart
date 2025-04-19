import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:traguard/features/bluetooth_connection/domain/brief_data.dart';
import 'package:traguard/features/bluetooth_connection/domain/gps_data.dart';
import 'package:traguard/utils/constants.dart';

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

/// A class that represents a Bluetooth reader.
/// It contains a list of Bluetooth services that can be used to
/// communicate with Bluetooth devices.
class BluetoothReader {
  /// Creates a new instance of [BluetoothReader].
  BluetoothReader({
    required this.connectedDevice,
    required this.service,
    required this.notifyCaracteristic,
    required this.writeCaracteristic,
  });

  /// The Bluetooth device that is connected.
  final BluetoothDevice connectedDevice;

  /// A list of Bluetooth services.
  final BluetoothService service;

  /// The characteristic used for reading notifications.
  final BluetoothCharacteristic notifyCaracteristic;

  /// The characteristic used for writing data.
  /// This is used to send commands to the Bluetooth device.
  final BluetoothCharacteristic writeCaracteristic;

  /// The battery level of the Bluetooth device.
  double batteryLevel = 0;

  /// The GPS state of the Bluetooth device.
  bool gpsActive = false;

  /// The device file list
  List<BriefData> fileList = [];

  /// The GPS data received from the Bluetooth device.
  List<double> processWidth = List.filled(16, 0);

  /// The GPS data received from the Bluetooth device.
  List<GpsData> gpsData = [];

  /// Listens for notifications from the Bluetooth device.
  Future<void> listenNotifications() async {
    final subscription = notifyCaracteristic.onValueReceived.listen((value) {
      if (value.isEmpty) {
        logger.e('Received empty notification');
        return;
      }
      _handleNotification(value);
    });

    connectedDevice.cancelWhenDisconnected(subscription);
    await notifyCaracteristic.setNotifyValue(true);
  }

  /// Requests the battery level and GPS state from the Bluetooth device.
  Future<void> requestBatteryAndGps() async {
    await writeCaracteristic.write(BluetoothCommands.batteryAndGps.getBytes());
  }

  /// Requests the brief from the Bluetooth device.
  Future<void> requestBrief() async {
    if (fileList.isNotEmpty) {
      fileList.clear();
    }
    await writeCaracteristic.write(BluetoothCommands.checkBrief.getBytes());
  }

  /// Requests the GPS data for each brief in the file list.
  Future<void> requestGpsDatas() async {
    if (fileList.isEmpty) {
      logger.e('No brief found');
      return;
    }
    // TODO(dariowskii): rendere dinamico per ogni brief
    final brief = fileList[0];
    await writeCaracteristic.write(
      BluetoothCommands.getGpsData.getBytes(briefId: brief.id),
    );
  }

  /*
  * ----------------
  * PRIVATE METHODS
  * ----------------
  */

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
    batteryLevel = (data[2] | (data[3] << 8)) / 100;
    gpsActive = data[4] & 0x01 == 1;

    const batteryMax = 4.10;
    const batteryMin = 3.6;

    batteryLevel =
        (batteryLevel - batteryMin) / (batteryMax - batteryMin) * 100;

    logger
      ..d('Battery level: ${batteryLevel.toStringAsFixed(0)} %')
      ..d('GPS state: $gpsActive');
  }

  void _analyzeBrief(List<int> data) {
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
  }

  void _analyzeGpsData(List<int> data) {
    final widths = List<double>.from(processWidth);
    var p = (data[1] + 1 + data[2] * 256) * 14 / fileList[0].length;
    if (p > 1) p = 1;

    widths[0] = p * 100;

    var gps = <GpsData>[];
    if (data[1] != 0) {
      gps = List.from(gpsData);
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

    processWidth = widths;
    gpsData = [
      ...{...gps},
    ];

    logger
      ..d('GPS data: ${jsonEncode(gps.map((e) => e.toJson()).toList())}')
      ..d('GPS data length: ${gps.length}')
      ..d('Process percentage: ${processWidth[0].toStringAsFixed(0)} %');
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
