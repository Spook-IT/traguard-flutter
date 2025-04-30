import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/chart_statistic_card.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistic_progress.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that displays the weekly goals of a team.
/// It shows the progress towards various goals such as training intensity,
class WeeklyGoals extends StatelessWidget {
  /// Creates a new instance of [WeeklyGoals].
  const WeeklyGoals({required this.model, super.key});

  /// The model that contains the weekly goals data.
  final WeeklyGoalsModel model;

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization
    final barColor = context.textTheme.labelLarge?.color ?? Colors.black87;
    return ChartStatisticCard(
      title: 'Obiettivi Settimanali',
      description: 'Progresso verso gli obiettivi',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Spaces.medium,
        children: [
          StatisticProgress(
            title: Text(
              'Intensità allenamento',
              style: context.textTheme.labelLarge,
            ),
            progressValue: model.trainingIntensity / 100,
            statisticValue: model.trainingIntensity,
            statisticUnit: '%',
            color: barColor,
          ),
          StatisticProgress(
            title: Text(
              'Distanza percorsa',
              style: context.textTheme.labelLarge,
            ),
            progressValue: model.distanceTraveled / 100,
            statisticValue: model.distanceTraveled,
            statisticUnit: '%',
            color: barColor,
          ),
          StatisticProgress(
            title: Text(
              'Precisione passaggi',
              style: context.textTheme.labelLarge,
            ),
            progressValue: model.precisionSteps / 100,
            statisticValue: model.precisionSteps,
            statisticUnit: '%',
            color: barColor,
          ),
          StatisticProgress(
            title: Text(
              'Qualità recupero',
              style: context.textTheme.labelLarge,
            ),
            progressValue: model.qualityRecovery / 100,
            statisticValue: model.qualityRecovery,
            statisticUnit: '%',
            color: barColor,
          ),
        ],
      ),
    );
  }
}
