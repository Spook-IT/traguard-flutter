import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_dynamic_body.dart';
import 'package:traguard/shared/providers/auth_provider.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/traguard_sliver_app_bar.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends ConsumerWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchTeamSessionsProvider);
    final sessionState = ref.watch(sessionManagerProvider);
    final hasActiveSession =
        sessionState.players.any((p) => p.isRecording);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TraguardSliverAppbar(
            title: context.l10n.teamStatisticsTitle,
            subtitle: context.l10n.teamStatisticsSubtitle,
            titleX: -0.75,
            titleY: 0.95,
            titleFactor: 0.15,
            subtitleFactor: 0.35,
            showBackButton: false,
            actions: [
              IconButton(
                tooltip: context.l10n.logout,
                onPressed: () =>
                    ref.read(authProvider.notifier).signOut(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          const SessionFilterWidget(),
          const StatisticsDynamicBody(),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () =>
                const SessionManagementRoute().go(context),
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
