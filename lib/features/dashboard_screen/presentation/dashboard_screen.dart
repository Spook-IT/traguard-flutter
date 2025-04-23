import 'package:flutter/material.dart';
import 'package:traguard/utils/extensions.dart';

/// The dashboard screen widget.
/// This widget serves as the main screen of the application,
/// displaying a welcome message to the user.
class DashboardScreen extends StatelessWidget {
  /// Creates a new instance of [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
