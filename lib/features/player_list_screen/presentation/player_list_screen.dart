import 'dart:async';

import 'package:flutter/material.dart';
import 'package:traguard/features/player_list_screen/presentation/player_list_body.dart';
import 'package:traguard/features/player_list_screen/presentation/search_player.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/traguard_sliver_app_bar.dart';

/// This widget is part of the player list feature of the application.
/// It displays a list of players and their statistics.
class PlayerListScreen extends StatefulWidget {
  /// Creates a new instance of [PlayerListScreen].
  const PlayerListScreen({super.key});

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late final _textController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _textController.dispose();
    _debounce?.cancel();
    _debounce = null;
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(500.ms, () {
      setState(() {});
    });
  }

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
          SliverToBoxAdapter(
            child: SearchPlayer(
              controller: _textController,
              onSendValue: _onSearchChanged,
            ),
          ),
          PlayerListBody(
            query:
                _textController.text.isNotEmpty ? _textController.text : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO(dariowskii): add localization
        },
        label: Text(context.l10n.newPlayer),
        icon: const Icon(Icons.person_add_alt),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
      ),
    );
  }
}
