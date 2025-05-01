// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Traguard';

  @override
  String get genericError => 'Si è verificato un errore';

  @override
  String get retryLater => 'Riprova più tardi';

  @override
  String get retry => 'Riprova';

  @override
  String get loginPageTitle => 'Accedi';

  @override
  String get loginInstruction => 'Inserisci le tue credenziali per accedere all\'app';

  @override
  String get email => 'Email';

  @override
  String get emailEmpty => 'L\'email non può essere vuota';

  @override
  String get emailInvalid => 'L\'email non è valida';

  @override
  String get password => 'Password';

  @override
  String get passwordEmpty => 'La password non può essere vuota';

  @override
  String get loginButton => 'Accedi';

  @override
  String get forgotPassword => 'Hai dimenticato la password?';

  @override
  String get register => 'Registrati';

  @override
  String get loginError => 'Errore durante l\'accesso.\nControlla le tue credenziali e riprova.';

  @override
  String get logout => 'Esci';

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

  @override
  String get teamStatisticsTitle => 'Gestione Squadra';

  @override
  String get teamStatisticsSubtitle => 'Statistiche e analisi di squadra';

  @override
  String get playersAvailability => 'Disponibilità atleti';

  @override
  String availabilitySpecs(int nActive, int nInjured, int nResting) {
    return 'Attivi: $nActive, Infortunati: $nInjured, Riposo: $nResting';
  }

  @override
  String availabilityPerc(int nPerc) {
    return '$nPerc% disponibili';
  }

  @override
  String get avarageTeamSpeed => 'Velocità Media Squadra';

  @override
  String get lastSession => 'Ultima sessione';

  @override
  String get totalDistance => 'Distanza Totale';

  @override
  String get performanceIndex => 'Indice Prestazione';

  @override
  String get avarageTeamFromLastSession => 'Media di squadra per ultima sessione';
}
