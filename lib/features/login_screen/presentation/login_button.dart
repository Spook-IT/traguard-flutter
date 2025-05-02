import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget represents a login button.
class LoginButton extends ConsumerWidget {
  /// Creates a new instance of [LoginButton].
  const LoginButton({super.key, this.onPressed, this.isLoading = false});

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onPressed;

  /// Indicates whether the button is in a loading state.
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(context.l10n.loginButton),
      ),
    );
  }
}
