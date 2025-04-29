import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistic_card.dart';
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
    // TODO(dariowskii): add localization
    final playersAvailability = statistics.playersAvailability;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Spaces.large,
      children: [
        StatisticCard(
          title: 'Disponibilità atleti',
          statisticValue: playersAvailability.totalPlayers.toDouble(),
          description:
              'Attivi: ${playersAvailability.activePlayers}, Infortunati: ${playersAvailability.injuredPlayers}, Riposo: ${playersAvailability.restPlayers}',
          bottomChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spaces.tiny,
            children: [
              LinearProgressIndicator(
                value: playersAvailability.availabilityPercentage / 100,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: context.colorScheme.outline.withValues(
                  alpha: .3,
                ),
                color: context.textTheme.labelLarge?.color,
              ),
              Text(
                '${playersAvailability.availabilityPercentage}% disponibili',
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        StatisticCard(
          title: 'Velocità Media Squadra',
          statisticValue: statistics.averageTeamSpeed,
          statisticUnit: 'km/h',
          description: 'Ultima sessione',
        ),
        StatisticCard(
          title: 'Distanza Totale',
          statisticValue: statistics.totalDistance,
          statisticUnit: 'km',
          description: 'Ultima sessione',
        ),
        StatisticCard(
          title: 'Indice Prestazione',
          statisticValue: statistics.performanceIndex,
          description: 'Media di scquadra per ultima sessione',
        ),
      ],
    );
  }
}
