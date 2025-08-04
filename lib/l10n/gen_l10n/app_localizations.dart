import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('it')
  ];

  /// No description provided for @appName.
  ///
  /// In it, this message translates to:
  /// **'Traguard'**
  String get appName;

  /// No description provided for @genericError.
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore'**
  String get genericError;

  /// No description provided for @retryLater.
  ///
  /// In it, this message translates to:
  /// **'Riprova più tardi'**
  String get retryLater;

  /// No description provided for @retry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get retry;

  /// No description provided for @longDate.
  ///
  /// In it, this message translates to:
  /// **'{date}'**
  String longDate(DateTime date);

  /// No description provided for @forwards.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, =0{Attaccanti} =1{Attaccante} other{Attaccanti}}'**
  String forwards(num count);

  /// No description provided for @midfielders.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, =0{Centrocampisti} =1{Centrocampista} other{Centrocampisti}}'**
  String midfielders(num count);

  /// No description provided for @defenders.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, =0{Difensori} =1{Difensore} other{Difensori}}'**
  String defenders(num count);

  /// No description provided for @goalkeepers.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, =0{Portieri} =1{Portiere} other{Portieri}}'**
  String goalkeepers(num count);

  /// No description provided for @athletes.
  ///
  /// In it, this message translates to:
  /// **'{count, plural, =0{Atleti} =1{Atleta} other{Atleti}}'**
  String athletes(num count);

  /// No description provided for @role.
  ///
  /// In it, this message translates to:
  /// **'Ruolo'**
  String get role;

  /// No description provided for @index.
  ///
  /// In it, this message translates to:
  /// **'Indice'**
  String get index;

  /// No description provided for @settings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get settings;

  /// No description provided for @user.
  ///
  /// In it, this message translates to:
  /// **'Utente'**
  String get user;

  /// No description provided for @general.
  ///
  /// In it, this message translates to:
  /// **'Generale'**
  String get general;

  /// No description provided for @notifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche'**
  String get notifications;

  /// No description provided for @security.
  ///
  /// In it, this message translates to:
  /// **'Sicurezza'**
  String get security;

  /// No description provided for @integrations.
  ///
  /// In it, this message translates to:
  /// **'Integrazioni'**
  String get integrations;

  /// No description provided for @name.
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @save.
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get save;

  /// No description provided for @velocity.
  ///
  /// In it, this message translates to:
  /// **'Velocità'**
  String get velocity;

  /// No description provided for @distance.
  ///
  /// In it, this message translates to:
  /// **'Distanza'**
  String get distance;

  /// No description provided for @performance.
  ///
  /// In it, this message translates to:
  /// **'Prestazione'**
  String get performance;

  /// No description provided for @status.
  ///
  /// In it, this message translates to:
  /// **'Stato'**
  String get status;

  /// No description provided for @number.
  ///
  /// In it, this message translates to:
  /// **'Numero'**
  String get number;

  /// No description provided for @team.
  ///
  /// In it, this message translates to:
  /// **'Squadra'**
  String get team;

  /// No description provided for @phone.
  ///
  /// In it, this message translates to:
  /// **'Telefono'**
  String get phone;

  /// No description provided for @nameAndSurname.
  ///
  /// In it, this message translates to:
  /// **'Nome e Cognome'**
  String get nameAndSurname;

  /// No description provided for @nameAndSurnameValidator.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il nome e cognome'**
  String get nameAndSurnameValidator;

  /// No description provided for @phoneEmpty.
  ///
  /// In it, this message translates to:
  /// **'Il numero di telefono non può essere vuoto'**
  String get phoneEmpty;

  /// No description provided for @dataSavedSuccessfully.
  ///
  /// In it, this message translates to:
  /// **'Dati salvati con successo'**
  String get dataSavedSuccessfully;

  /// No description provided for @loginPageTitle.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get loginPageTitle;

  /// No description provided for @loginInstruction.
  ///
  /// In it, this message translates to:
  /// **'Inserisci le tue credenziali per accedere all\'app'**
  String get loginInstruction;

  /// No description provided for @email.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailEmpty.
  ///
  /// In it, this message translates to:
  /// **'L\'email non può essere vuota'**
  String get emailEmpty;

  /// No description provided for @emailInvalid.
  ///
  /// In it, this message translates to:
  /// **'L\'email non è valida'**
  String get emailInvalid;

  /// No description provided for @password.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordEmpty.
  ///
  /// In it, this message translates to:
  /// **'La password non può essere vuota'**
  String get passwordEmpty;

  /// No description provided for @loginButton.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get loginButton;

  /// No description provided for @forgotPassword.
  ///
  /// In it, this message translates to:
  /// **'Hai dimenticato la password?'**
  String get forgotPassword;

  /// No description provided for @register.
  ///
  /// In it, this message translates to:
  /// **'Registrati'**
  String get register;

  /// No description provided for @loginError.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'accesso.\nControlla le tue credenziali e riprova.'**
  String get loginError;

  /// No description provided for @logout.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get logout;

  /// No description provided for @bluetoothDeviceList.
  ///
  /// In it, this message translates to:
  /// **'Dispositivi Bluetooth'**
  String get bluetoothDeviceList;

  /// No description provided for @bluetoothNotSupportedOnDevice.
  ///
  /// In it, this message translates to:
  /// **'Bluetooth non supportato su questo dispositivo'**
  String get bluetoothNotSupportedOnDevice;

  /// No description provided for @bluetoothOff.
  ///
  /// In it, this message translates to:
  /// **'Bluetooth spento'**
  String get bluetoothOff;

  /// No description provided for @pleaseTurnOnBluetooth.
  ///
  /// In it, this message translates to:
  /// **'Per favore accendi il Bluetooth per continuare'**
  String get pleaseTurnOnBluetooth;

  /// No description provided for @connect.
  ///
  /// In it, this message translates to:
  /// **'Connetti'**
  String get connect;

  /// No description provided for @disconnect.
  ///
  /// In it, this message translates to:
  /// **'Disconnetti'**
  String get disconnect;

  /// No description provided for @availableDevices.
  ///
  /// In it, this message translates to:
  /// **'Dispositivi disponibili'**
  String get availableDevices;

  /// No description provided for @connectedDevices.
  ///
  /// In it, this message translates to:
  /// **'Dispositivi connessi'**
  String get connectedDevices;

  /// No description provided for @sessionManagement.
  ///
  /// In it, this message translates to:
  /// **'Gestione sessione'**
  String get sessionManagement;

  /// No description provided for @noDevicesConnected.
  ///
  /// In it, this message translates to:
  /// **'Nessun dispositivo connesso'**
  String get noDevicesConnected;

  /// No description provided for @stopSession.
  ///
  /// In it, this message translates to:
  /// **'Ferma sessione'**
  String get stopSession;

  /// No description provided for @recording.
  ///
  /// In it, this message translates to:
  /// **'Registrazione in corso'**
  String get recording;

  /// No description provided for @paused.
  ///
  /// In it, this message translates to:
  /// **'In pausa'**
  String get paused;

  /// No description provided for @teamStatisticsTitle.
  ///
  /// In it, this message translates to:
  /// **'Gestione Squadra'**
  String get teamStatisticsTitle;

  /// No description provided for @teamStatisticsSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Statistiche e analisi di squadra'**
  String get teamStatisticsSubtitle;

  /// No description provided for @playersAvailability.
  ///
  /// In it, this message translates to:
  /// **'Disponibilità atleti'**
  String get playersAvailability;

  /// No description provided for @availabilitySpecs.
  ///
  /// In it, this message translates to:
  /// **'Attivi: {nActive}, Infortunati: {nInjured}, Riposo: {nResting}'**
  String availabilitySpecs(int nActive, int nInjured, int nResting);

  /// No description provided for @availabilityPerc.
  ///
  /// In it, this message translates to:
  /// **'{nPerc}% disponibili'**
  String availabilityPerc(int nPerc);

  /// No description provided for @averageTeamSpeed.
  ///
  /// In it, this message translates to:
  /// **'Velocità Media Squadra'**
  String get averageTeamSpeed;

  /// No description provided for @lastSession.
  ///
  /// In it, this message translates to:
  /// **'Ultima sessione'**
  String get lastSession;

  /// No description provided for @totalDistance.
  ///
  /// In it, this message translates to:
  /// **'Distanza Totale'**
  String get totalDistance;

  /// No description provided for @performanceIndex.
  ///
  /// In it, this message translates to:
  /// **'Indice Prestazione'**
  String get performanceIndex;

  /// No description provided for @averageTeamFromLastSession.
  ///
  /// In it, this message translates to:
  /// **'Media di squadra per ultima sessione'**
  String get averageTeamFromLastSession;

  /// No description provided for @averageSpeed.
  ///
  /// In it, this message translates to:
  /// **'Velocità Media'**
  String get averageSpeed;

  /// No description provided for @topSpeed.
  ///
  /// In it, this message translates to:
  /// **'Velocità Massima'**
  String get topSpeed;

  /// No description provided for @distanceWalked.
  ///
  /// In it, this message translates to:
  /// **'Distanza Percorsa'**
  String get distanceWalked;

  /// No description provided for @firstHalfPercentagePresence.
  ///
  /// In it, this message translates to:
  /// **'Presenza prima del centro campo'**
  String get firstHalfPercentagePresence;

  /// No description provided for @secondHalfPercentagePresence.
  ///
  /// In it, this message translates to:
  /// **'Presenza dopo il centro campo'**
  String get secondHalfPercentagePresence;

  /// No description provided for @roleComposition.
  ///
  /// In it, this message translates to:
  /// **'Composizione Ruoli'**
  String get roleComposition;

  /// No description provided for @progressTowardsGoals.
  ///
  /// In it, this message translates to:
  /// **'Progresso verso gli obiettivi'**
  String get progressTowardsGoals;

  /// No description provided for @sessionTrends.
  ///
  /// In it, this message translates to:
  /// **'Trend Sessioni'**
  String get sessionTrends;

  /// No description provided for @sessionTrendsSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Confronto delle prestazioni degli atleti nelle diverse sessioni'**
  String get sessionTrendsSubtitle;

  /// No description provided for @metric.
  ///
  /// In it, this message translates to:
  /// **'Metrica'**
  String get metric;

  /// No description provided for @topAthletes.
  ///
  /// In it, this message translates to:
  /// **'Atleti Più Performanti'**
  String get topAthletes;

  /// No description provided for @topAthletesSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Top 5 per indice prestazionale'**
  String get topAthletesSubtitle;

  /// No description provided for @weeklyGoals.
  ///
  /// In it, this message translates to:
  /// **'Obiettivi Settimanali'**
  String get weeklyGoals;

  /// No description provided for @trainingIntensity.
  ///
  /// In it, this message translates to:
  /// **'Intensità Allenamento'**
  String get trainingIntensity;

  /// No description provided for @distanceTraveled.
  ///
  /// In it, this message translates to:
  /// **'Distanza Percorsa'**
  String get distanceTraveled;

  /// No description provided for @precisionSteps.
  ///
  /// In it, this message translates to:
  /// **'Precisione passaggi'**
  String get precisionSteps;

  /// No description provided for @qualityRecovery.
  ///
  /// In it, this message translates to:
  /// **'Qualità recupero'**
  String get qualityRecovery;

  /// No description provided for @playerListTitle.
  ///
  /// In it, this message translates to:
  /// **'Lista Atleti'**
  String get playerListTitle;

  /// No description provided for @playerListSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Gestione e visualizzazione dati degli atleti'**
  String get playerListSubtitle;

  /// No description provided for @newPlayer.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Atleta'**
  String get newPlayer;

  /// No description provided for @active.
  ///
  /// In it, this message translates to:
  /// **'Attivo'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In it, this message translates to:
  /// **'Non attivo'**
  String get inactive;

  /// No description provided for @injured.
  ///
  /// In it, this message translates to:
  /// **'Infortunato'**
  String get injured;

  /// No description provided for @searchAthletes.
  ///
  /// In it, this message translates to:
  /// **'Cerca atleti...'**
  String get searchAthletes;

  /// No description provided for @createPlayerTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Atleta'**
  String get createPlayerTitle;

  /// No description provided for @createPlayerSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Inserisci i dati dell\'atleta da aggiungere'**
  String get createPlayerSubtitle;

  /// No description provided for @playerCreatedSuccessfully.
  ///
  /// In it, this message translates to:
  /// **'Giocatore creato con successo'**
  String get playerCreatedSuccessfully;

  /// No description provided for @errorCreatingPlayer.
  ///
  /// In it, this message translates to:
  /// **'Errore durante la creazione del giocatore: {error}'**
  String errorCreatingPlayer(String error);

  /// No description provided for @numberValidator.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il numero'**
  String get numberValidator;

  /// No description provided for @pickAColor.
  ///
  /// In it, this message translates to:
  /// **'Scegli un colore'**
  String get pickAColor;

  /// No description provided for @invalidHexColorFormat.
  ///
  /// In it, this message translates to:
  /// **'Il formato del colore esadecimale non è valido'**
  String get invalidHexColorFormat;

  /// No description provided for @selectedColor.
  ///
  /// In it, this message translates to:
  /// **'Colore selezionato'**
  String get selectedColor;

  /// No description provided for @fiscalDataTitle.
  ///
  /// In it, this message translates to:
  /// **'Dati Fiscali'**
  String get fiscalDataTitle;

  /// No description provided for @legalRepresentitive.
  ///
  /// In it, this message translates to:
  /// **'Rappresentante Legale'**
  String get legalRepresentitive;

  /// No description provided for @errorSavingData.
  ///
  /// In it, this message translates to:
  /// **'Errore durante il salvataggio dei dati: {error}'**
  String errorSavingData(String error);

  /// No description provided for @legalAddress.
  ///
  /// In it, this message translates to:
  /// **'Indirizzo Legale'**
  String get legalAddress;

  /// No description provided for @legalAddressEmpty.
  ///
  /// In it, this message translates to:
  /// **'L\'indirizzo legale non può essere vuoto'**
  String get legalAddressEmpty;

  /// No description provided for @teamName.
  ///
  /// In it, this message translates to:
  /// **'Nome Squadra'**
  String get teamName;

  /// No description provided for @teamNameEmpty.
  ///
  /// In it, this message translates to:
  /// **'Il nome della squadra non può essere vuoto'**
  String get teamNameEmpty;

  /// No description provided for @legalEmail.
  ///
  /// In it, this message translates to:
  /// **'Email Legale'**
  String get legalEmail;

  /// No description provided for @legalEmailEmpty.
  ///
  /// In it, this message translates to:
  /// **'L\'email legale non può essere vuota'**
  String get legalEmailEmpty;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
