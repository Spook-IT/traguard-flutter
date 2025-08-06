import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/player_list_screen/presentation/player_list_body.dart';
import 'package:traguard/features/player_list_screen/presentation/search_player.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the player list feature of the application.
/// It displays a list of players and their statistics.
class PlayerListScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [PlayerListScreen].
  const PlayerListScreen({super.key});

  @override
  ConsumerState<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends ConsumerState<PlayerListScreen> {
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
    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.playerListTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.newPlayer,
            onPressed: () => const CreatePlayerRoute().go(context),
            icon: const Icon(Icons.person_add_alt),
          ),
          IconButton(
            tooltip: context.l10n.logout,
            onPressed: () => ref.read(authProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchPlayer(
            controller: _textController,
            onSendValue: _onSearchChanged,
          ),
          Expanded(
            child: PlayerListBody(
              query: _textController.text.isNotEmpty
                  ? _textController.text
                  : null,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () => const NewSessionRoute().go(context),
            child:
                Icon(hasActiveSession ? Icons.play_arrow : Icons.add),
          ),
          if (hasActiveSession)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: context.colorScheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: Spaces.small,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Giocatori',
              icon: const Icon(Icons.people),
              onPressed: () => const PlayerListRoute().go(context),
            ),
            IconButton(
              tooltip: 'Dispositivi',
              icon: const Icon(Icons.devices),
              onPressed: () => const BluetoothListRoute().go(context),
            ),
            const SizedBox(width: 48),
            IconButton(
              tooltip: 'Dashboard',
              icon: const Icon(Icons.home),
              onPressed: () => const DashboardRoute().go(context),
            ),
            IconButton(
              tooltip: 'Dati Fiscali',
              icon: const Icon(Icons.receipt_long),
              onPressed: () => const FiscalDataRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}
