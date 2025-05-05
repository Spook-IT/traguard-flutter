import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/traguard_sliver_app_bar.dart';

/// This widget is part of the player list feature of the application.
/// It displays a list of players and their statistics.
class PlayerListScreen extends StatelessWidget {
  /// Creates a new instance of [PlayerListScreen].
  const PlayerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TraguardSliverAppbar(
            title: context.l10n.playerListTitle,
            subtitle: context.l10n.playerListSubtitle,
            titleX: -0.45,
            titleY: 0.95,
            titleFactor: 0.15,
            subtitleFactor: 0.4,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO(dariowskii): add localization
        },
        label: const Text('Add Player'),
        icon: const Icon(Icons.add),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
      ),
    );
  }
}
