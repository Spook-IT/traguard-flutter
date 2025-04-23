import 'package:flutter/material.dart';
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
      body: Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
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
            const ListTile(title: Text('Item 1')),
            const ListTile(title: Text('Item 2')),
          ],
        ),
      ),
    );
  }
}
