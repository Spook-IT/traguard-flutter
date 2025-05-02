import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/shared/models/user.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that displays the user information in the drawer section.
/// It shows the user's name, role, and a settings icon button.
class UserDrawerSection extends ConsumerWidget {
  /// Creates a new instance of [UserDrawerSection].
  const UserDrawerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      authProvider.select((userAsync) {
        if (userAsync is AsyncData) {
          final user = userAsync.value;
          return switch (user) {
            SignedIn(:final fullName, :final role) => (fullName, role),
            _ => (null, null),
          };
        }
        return (null, null);
      }),
    );

    final name = user.$1 ?? '';
    final role = user.$2 ?? '';

    final letters =
        name.split(' ').map((e) => e[0].toUpperCase()).toList().join();

    return Row(
      spacing: Spaces.small,
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.onPrimaryFixed,
          radius: 20,
          child: Padding(
            padding: Paddings.smallAll,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  letters,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.primaryFixed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onPrimaryFixed,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Text(
                role,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onPrimaryFixed,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          color: context.colorScheme.onPrimaryFixed,
          onPressed: () {
            // TODO(dariowskii): go to use settings page
          },
        ),
      ],
    );
  }
}
