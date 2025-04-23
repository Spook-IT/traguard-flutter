import 'package:flutter/material.dart';
import 'package:traguard/features/login_screen/presentation/login_text_field.dart';
import 'package:traguard/router/routes.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// A screen that displays a login form.
class LoginScreen extends StatefulWidget {
  /// Creates a new instance of [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryLogin() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    // TODO(dariowskii): Implement login logic
    // Perform login action
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login successful!')));

    const DashboardRoute().go(context);
  }

  void _goToRegister() {
    // TODO(dariowskii): Implement navigation to register page
  }

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.appName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spaces.xLarge.sizedBoxHeight,
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    children: [
                      LoginTextField(
                        label: context.l10n.email,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.emailEmpty;
                          }

                          if (!value.isValidEmail) {
                            return context.l10n.emailInvalid;
                          }

                          return null;
                        },
                      ),
                      Spaces.medium.sizedBoxHeight,
                      LoginTextField(
                        label: context.l10n.password,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.passwordEmpty;
                          }

                          return null;
                        },
                      ),
                      Spaces.xLarge.sizedBoxHeight,
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _tryLogin,
                          child: Text(context.l10n.loginButton),
                        ),
                      ),
                      Spaces.tiny.sizedBoxHeight,
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _goToRegister,
                          child: Text(context.l10n.register),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
