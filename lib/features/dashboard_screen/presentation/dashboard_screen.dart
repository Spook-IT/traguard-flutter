import 'package:flutter/material.dart';
import 'package:traguard/router/routes.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// The dashboard screen widget.
/// This widget serves as the main screen of the application,
/// displaying a welcome message to the user.
class DashboardScreen extends StatelessWidget {
  /// Creates a new instance of [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome to the Dashboard!',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryFixed,
              ),
              child: Column(
                spacing: Spaces.small,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.appName,
                    style: context.textTheme.displaySmall?.copyWith(
                      color: context.colorScheme.onPrimaryFixed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'The tracking app for soccer players',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                '📍 Vai alle mappe',
                style: context.textTheme.titleLarge,
              ),
              onTap: () {
                // TODO(dariowskii): add functionality
              },
            ),
            ListTile(
              title: Text(
                '🎽 Guarda le sessioni',
                style: context.textTheme.titleLarge,
              ),
              onTap: () {
                // TODO(dariowskii): add functionality
              },
            ),
            ListTile(
              title: Text('⚽ Giocatori', style: context.textTheme.titleLarge),
              onTap: () {
                // TODO(dariowskii): add functionality
              },
            ),
            ListTile(
              title: Text(
                '📊 Gestione Squadra',
                style: context.textTheme.titleLarge,
              ),
              onTap: () {
                const TeamStatisticsRoute().go(context);
              },
            ),
            ListTile(
              title: Text(
                '📱 Dispositivi',
                style: context.textTheme.titleLarge,
              ),
              onTap: () {
                const BluetoothListRoute().go(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO(dariowskii): add functionality
        },
        label: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: Spaces.tiny),
            Text('Nuova sessione'),
          ],
        ),
      ),
    );
  }
}
