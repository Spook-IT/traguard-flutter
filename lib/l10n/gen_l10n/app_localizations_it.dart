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
  String longDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String forwards(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Attaccanti',
      one: 'Attaccante',
      zero: 'Attaccanti',
    );
    return '$_temp0';
  }

  @override
  String midfielders(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Centrocampisti',
      one: 'Centrocampista',
      zero: 'Centrocampisti',
    );
    return '$_temp0';
  }

  @override
  String defenders(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Difensori',
      one: 'Difensore',
      zero: 'Difensori',
    );
    return '$_temp0';
  }

  @override
  String goalkeepers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Portieri',
      one: 'Portiere',
      zero: 'Portieri',
    );
    return '$_temp0';
  }

  @override
  String athletes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Atleti',
      one: 'Atleta',
      zero: 'Atleti',
    );
    return '$_temp0';
  }

  @override
  String get role => 'Ruolo';

  @override
  String get index => 'Indice';

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
  String get averageTeamSpeed => 'Velocità Media Squadra';

  @override
  String get lastSession => 'Ultima sessione';

  @override
  String get totalDistance => 'Distanza Totale';

  @override
  String get performanceIndex => 'Indice Prestazione';

  @override
  String get averageTeamFromLastSession => 'Media di squadra per ultima sessione';

  @override
  String get averageSpeed => 'Velocità Media';

  @override
  String get topSpeed => 'Velocità Massima';

  @override
  String get distanceWalked => 'Distanza Percorsa';

  @override
  String get firstHalfPercentagePresence => 'Presenza prima del centro campo';

  @override
  String get secondHalfPercentagePresence => 'Presenza dopo il centro campo';

  @override
  String get roleComposition => 'Composizione Ruoli';

  @override
  String get progressTowardsGoals => 'Progresso verso gli obiettivi';

  @override
  String get sessionTrends => 'Trend Sessioni';

  @override
  String get sessionTrendsSubtitle => 'Confronto delle prestazioni degli atleti nelle diverse sessioni';

  @override
  String get metric => 'Metrica';

  @override
  String get topAthletes => 'Atleti Più Performanti';

  @override
  String get topAthletesSubtitle => 'Top 5 per indice prestazionale';

  @override
  String get weeklyGoals => 'Obiettivi Settimanali';

  @override
  String get trainingIntensity => 'Intensità Allenamento';

  @override
  String get distanceTraveled => 'Distanza Percorsa';

  @override
  String get precisionSteps => 'Precisione passaggi';

  @override
  String get qualityRecovery => 'Qualità recupero';
}
