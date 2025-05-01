import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/loading_statistics.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_header.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_loaded_body.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends ConsumerWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsAsync = ref.watch(fetchStatisticsProvider).unwrapPrevious();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const StatisticsHeader(),
          switch (statisticsAsync) {
            AsyncData(:final value) => SliverToBoxAdapter(
              child: StatisticsLoadedBody(statistics: value),
            ),
            AsyncError(:final error) => SliverFillRemaining(
              hasScrollBody: false,
              child: ErrorRetry(
                error: error,
                onRetry: () => ref.refresh(fetchStatisticsProvider),
              ),
            ),
            _ => const SliverToBoxAdapter(child: LoadingStatistics()),
          },
        ],
      ),
    );
  }
}
