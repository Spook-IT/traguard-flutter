import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/base_statistic_card.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistic_progress.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that displays the role composition of a team.
class RoleComposition extends StatelessWidget {
  /// Creates a new instance of [RoleComposition].
  const RoleComposition({required this.model, super.key});

  /// The model that contains the role composition data.
  final RoleCompositionModel model;

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization
    return BaseStatisticCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Composizione Ruoli',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spaces.tiny.sizedBoxHeight,
          Text(
            'Progresso verso gli obiettivi',
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: .5),
            ),
          ),
          Spaces.large.sizedBoxHeight,
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Spaces.medium,
            children: [
              StatisticProgress(
                title: Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.purple, size: 16),
                    Spaces.tiny.sizedBoxWidth,
                    const Text('Attaccanti'),
                  ],
                ),
                progressValue: model.forward / model.totalPlayers,
                statisticValue: model.forward,
                color: Colors.purple,
              ),
              StatisticProgress(
                title: Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.blue, size: 16),
                    Spaces.tiny.sizedBoxWidth,
                    const Text('Centrocampisti'),
                  ],
                ),
                progressValue: model.midfielder / model.totalPlayers,
                statisticValue: model.midfielder,
                color: Colors.blue,
              ),
              StatisticProgress(
                title: Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.green, size: 16),
                    Spaces.tiny.sizedBoxWidth,
                    const Text('Difensori'),
                  ],
                ),
                progressValue: model.defender / model.totalPlayers,
                statisticValue: model.defender,
                color: Colors.green,
              ),
              StatisticProgress(
                title: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.orangeAccent,
                      size: 16,
                    ),
                    Spaces.tiny.sizedBoxWidth,
                    const Text('Portieri'),
                  ],
                ),
                progressValue: model.goalkeeper / model.totalPlayers,
                statisticValue: model.goalkeeper,
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
