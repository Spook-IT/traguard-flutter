import 'package:flutter/material.dart';
import 'package:traguard/features/create_player/presentation/insert_player_form.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/traguard_sliver_app_bar.dart';

/// A widget that represents the screen for creating a new player.
class CreatePlayerScreen extends StatelessWidget {
  /// Creates a new instance of [CreatePlayerScreen].
  const CreatePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TraguardSliverAppbar(
            title: context.l10n.createPlayerTitle,
            subtitle: context.l10n.createPlayerSubtitle,
            subtitleFactor: 0.4,
            titleX: -0.55,
            titleY: 0.95,
            titleFactor: 0.15,
          ),
          const InsertPlayerForm(),
        ],
      ),
    );
  }
}
