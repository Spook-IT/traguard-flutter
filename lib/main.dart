import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/l10n/gen_l10n/app_localizations.dart';
import 'package:traguard/router/router.dart';

void main() {
  runApp(const ProviderScope(child: TraguarApp()));
}

/// The main application widget.
class TraguarApp extends ConsumerWidget {
  /// Creates a new instance of [TraguarApp].
  const TraguarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Traguar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
