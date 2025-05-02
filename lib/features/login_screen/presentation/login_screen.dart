import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/login_screen/presentation/login_button.dart';
import 'package:traguard/features/login_screen/presentation/login_text_field.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/utils/constants.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A screen that displays a login form.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [LoginScreen].
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  var _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _tryLogin() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      logger.e('Email or password is empty');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(authProvider.notifier)
          .signIn(email: email, password: password);
    } on Exception catch (e) {
      logger.e('Login failed', error: e);
      return;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                        enabled: !_isLoading,
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
                        enabled: !_isLoading,
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
                      LoginButton(onPressed: _tryLogin, isLoading: _isLoading),
                      Spaces.tiny.sizedBoxHeight,
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _isLoading ? null : _goToRegister,
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
