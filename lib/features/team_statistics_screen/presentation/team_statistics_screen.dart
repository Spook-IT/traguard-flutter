import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/team_statistics_screen/data/use_cases.dart';
import 'package:traguard/features/team_statistics_screen/presentation/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_dynamic_body.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistics_header.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends ConsumerWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchTeamSessionsProvider);
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          StatisticsHeader(),
          SessionFilterWidget(),
          StatisticsDynamicBody(),
        ],
      ),
    );
  }
}
