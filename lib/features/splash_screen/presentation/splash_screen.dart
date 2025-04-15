import 'package:flutter/material.dart';

/// This is the splash screen of the application. It is shown when the
/// application is launched and is used to display a logo or a loading
/// indicator while the application is loading.
class SplashScreen extends StatelessWidget {
  /// Creates a new instance of [SplashScreen].
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
