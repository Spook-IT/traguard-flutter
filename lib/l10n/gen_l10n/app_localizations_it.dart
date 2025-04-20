// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get bluetoothDeviceList => 'Dispositivi Bluetooth';

  @override
  String get bluetoothNotSupportedOnDevice => 'Bluetooth non supportato su questo dispositivo';

  @override
  String get bluetoothOff => 'Bluetooth spento';

  @override
  String get pleaseTurnOnBluetooth => 'Per favore accendi il Bluetooth per continuare';

  @override
  String get connect => 'Connetti';

  @override
  String get disconnect => 'Disconnetti';

  @override
  String get availableDevices => 'Dispositivi disponibili';

  @override
  String get connectedDevices => 'Dispositivi connessi';
}
