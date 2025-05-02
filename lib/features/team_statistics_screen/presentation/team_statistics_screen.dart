import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/loading_statistics.dart';
import 'package:traguard/features/team_statistics_screen/presentation/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_header.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_loaded_body.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends ConsumerWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchTeamSessionsProvider).unwrapPrevious();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const StatisticsHeader(),
          const SessionFilterWidget(),
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, _) {
                final selectedSession = ref.watch(
                  sessionFilterProvider.select((state) {
                    return switch (state) {
                      SessionFilterData(:final selectedSession) =>
                        selectedSession,
                      _ => null,
                    };
                  }),
                );

                if (selectedSession == null) {
                  return const LoadingStatistics();
                }

                final statisticsAsync = ref.watch(
                  fetchStatisticsProvider(sessionId: selectedSession.id),
                );

                return switch (statisticsAsync) {
                  AsyncData(:final value) => StatisticsLoadedBody(
                    statistics: value,
                  ),
                  AsyncError(:final error) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorRetry(
                      error: error,
                      onRetry:
                          () => ref.refresh(
                            fetchStatisticsProvider(
                              sessionId: selectedSession.id,
                            ),
                          ),
                    ),
                  ),
                  _ => const LoadingStatistics(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
