import 'package:flutter/material.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// A screen that displays a login form.
class LoginScreen extends StatelessWidget {
  /// Creates a new instance of [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.loginPageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: Paddings.largeAll,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login Form'),
                // Add your login form widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
