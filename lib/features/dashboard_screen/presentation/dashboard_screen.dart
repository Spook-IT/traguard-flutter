import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// The dashboard screen widget.
/// This widget serves as the main screen of the application,
/// displaying a welcome message to the user.
class DashboardScreen extends ConsumerWidget {
  /// Creates a new instance of [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(dariowskii): add localization
    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: context.l10n.logout,
            onPressed: () =>
                ref.read(authProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome to the Dashboard!',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              const SessionManagementRoute().go(context);
            },
            child: Icon(
              hasActiveSession ? Icons.play_arrow : Icons.add,
            ),
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
              tooltip: 'Statistiche',
              icon: const Icon(Icons.bar_chart),
              onPressed: () => const TeamStatisticsRoute().go(context),
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
