import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that displays a logout button.
class LogoutButton extends ConsumerWidget {
  /// Creates a new instance of [LogoutButton].
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: Paddings.mediumAll,
        child: OutlinedButton(
          onPressed: () {
            ref.read(authProvider.notifier).signOut();
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: context.colorScheme.error,
            side: BorderSide(color: context.colorScheme.error),
          ),
          child: Text(context.l10n.logout),
        ),
      ),
    );
  }
}
