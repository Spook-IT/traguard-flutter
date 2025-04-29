import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/loading_statistics.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_header.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_loaded_body.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends ConsumerWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsAsync = ref.watch(fetchStatisticsProvider).unwrapPrevious();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await HapticFeedback.mediumImpact();
            ref.invalidate(fetchStatisticsProvider);
          },
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            padding: Paddings.mediumAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Spaces.large,
              children: [
                const StatisticsHeader(),
                switch (statisticsAsync) {
                  AsyncData(:final value) => StatisticsLoadedBody(
                    statistics: value,
                  ),
                  _ => const LoadingStatistics(),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
