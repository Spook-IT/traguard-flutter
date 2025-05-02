import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/common_linear_progress.dart';
import 'package:traguard/features/team_statistics_screen/presentation/role_composition.dart';
import 'package:traguard/features/team_statistics_screen/presentation/session_trends.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistic_card.dart';
import 'package:traguard/features/team_statistics_screen/presentation/top_athlets.dart';
import 'package:traguard/features/team_statistics_screen/presentation/weekly_goals.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
/// It displays the loaded statistics data in a card format.
class StatisticsLoadedBody extends StatelessWidget {
  /// Creates a new instance of [StatisticsLoadedBody].
  const StatisticsLoadedBody({required this.statistics, super.key});

  /// The statistics data to be displayed.
  final TeamStatisticsModel statistics;

  @override
  Widget build(BuildContext context) {
    final playersAvailability = statistics.playersAvailability;
    return Padding(
      padding: Paddings.mediumAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Spaces.large,
        children: [
          StatisticCard(
            title: context.l10n.playersAvailability,
            statisticValue: playersAvailability.totalPlayers.toDouble(),
            precision: 0,
            description: context.l10n.availabilitySpecs(
              playersAvailability.activePlayers,
              playersAvailability.injuredPlayers,
              playersAvailability.restPlayers,
            ),
            bottomChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spaces.tiny,
              children: [
                CommonLinearProgress(
                  value: playersAvailability.availabilityPercentage / 100,
                  color: context.textTheme.labelLarge?.color,
                ),
                Text(
                  context.l10n.availabilityPerc(
                    playersAvailability.availabilityPercentage,
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          StatisticCard(
            title: context.l10n.averageTeamSpeed,
            precision: 1,
            statisticValue: statistics.averageTeamSpeed,
            statisticUnit: 'km/h',
            description: context.l10n.lastSession,
            animationDelay: 150.ms,
          ),
          StatisticCard(
            title: context.l10n.totalDistance,
            precision: 1,
            statisticValue: statistics.totalDistance,
            statisticUnit: 'km',
            description: context.l10n.lastSession,
            animationDelay: 300.ms,
          ),
          StatisticCard(
            title: context.l10n.performanceIndex,
            precision: 1,
            statisticValue: statistics.performanceIndex,
            description: context.l10n.averageTeamFromLastSession,
            animationDelay: 450.ms,
          ),
          RoleComposition(model: statistics.roleComposition),
          WeeklyGoals(model: statistics.weeklyGoals),
          TopAthletes(athletes: statistics.topAthletes),
          SessionTrends(playerTrends: statistics.playerTrends),
          Spaces.large.sizedBoxHeight,
        ],
      ),
    );
  }
}
