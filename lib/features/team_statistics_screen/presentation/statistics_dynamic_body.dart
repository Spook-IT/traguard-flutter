import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/loading_statistics.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_loaded_body.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget is part of the team statistics feature of the application.
/// It provides a dynamic body for the statistics section.
class StatisticsDynamicBody extends ConsumerWidget {
  /// Creates a new instance of [StatisticsDynamicBody].
  const StatisticsDynamicBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, _) {
          final selectedSession = ref.watch(
            sessionFilterProvider.select((state) {
              return switch (state) {
                SessionFilterData(:final selectedSession) => selectedSession,
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
            AsyncData(:final value) => StatisticsLoadedBody(statistics: value),
            AsyncError(:final error) => Padding(
              padding: Paddings.xLargeTop,
              child: ErrorRetry(
                error: error,
                onRetry:
                    () => ref.refresh(
                      fetchStatisticsProvider(sessionId: selectedSession.id),
                    ),
              ),
            ),
            _ => const LoadingStatistics(),
          };
        },
      ),
    );
  }
}
