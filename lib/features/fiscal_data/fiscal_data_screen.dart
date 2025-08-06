import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that represents the screen for displaying fiscal data.
class FiscalDataScreen extends ConsumerWidget {
  /// Creates a new instance of [FiscalDataScreen].
  const FiscalDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fiscalDataTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.logout,
            onPressed: () =>
                ref.read(authProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: CupertinoListSection.insetGrouped(
        children: [
          CupertinoListTile.notched(
            title: Text(
              l10n.legalRepresentitive,
              style: TextStyle(color: context.colorScheme.onSurface),
            ),
            leading: Icon(Icons.person, color: context.colorScheme.primary),
            trailing: const CupertinoListTileChevron(),
            onTap: () {
              const UpdateLegalDataRoute().go(context);
            },
          ),
          CupertinoListTile.notched(
            title: Text(
              l10n.team,
              style: TextStyle(color: context.colorScheme.onSurface),
            ),
            leading: Icon(
              Icons.sports_soccer,
              color: context.colorScheme.primary,
            ),
            trailing: const CupertinoListTileChevron(),
            onTap: () {
              const UpdateTeamDataRoute().go(context);
            },
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
