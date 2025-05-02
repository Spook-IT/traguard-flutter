import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/l10n/gen_l10n/app_localizations.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'package:traguard/shared/router/router.dart';
import 'package:traguard/shared/utils/constants.dart';
import 'package:traguard/shared/utils/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: TraguarApp()));
}

/// The main application widget.
class TraguarApp extends ConsumerWidget {
  /// Creates a new instance of [TraguarApp].
  const TraguarApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _EagerInitialization(
      child: MaterialApp.router(
        theme: lightTheme,
        onGenerateTitle: (context) => context.l10n.appName,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: ref.watch(routerProvider),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(authProvider)
      ..watch(connectedDevicesProvider);
    return child;
  }
}
