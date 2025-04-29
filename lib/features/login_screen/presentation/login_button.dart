import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget represents a login button.
class LoginButton extends ConsumerWidget {
  /// Creates a new instance of [LoginButton].
  const LoginButton({super.key, this.onPressed});

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(context.l10n.loginButton),
      ),
    );
  }
}
