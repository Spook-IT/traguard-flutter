import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/chart_statistic_card.dart';
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
    return ChartStatisticCard(
      title: context.l10n.roleComposition,
      description: context.l10n.progressTowardsGoals,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Spaces.medium,
        children: [
          StatisticProgress(
            title: Row(
              children: [
                const Icon(Icons.circle, color: Colors.purple, size: 16),
                Spaces.tiny.sizedBoxWidth,
                Text(context.l10n.forwards(2)),
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
                Text(context.l10n.midfielders(2)),
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
                Text(context.l10n.defenders(2)),
              ],
            ),
            progressValue: model.defender / model.totalPlayers,
            statisticValue: model.defender,
            color: Colors.green,
          ),
          StatisticProgress(
            title: Row(
              children: [
                const Icon(Icons.circle, color: Colors.orangeAccent, size: 16),
                Spaces.tiny.sizedBoxWidth,
                Text(context.l10n.goalkeepers(2)),
              ],
            ),
            progressValue: model.goalkeeper / model.totalPlayers,
            statisticValue: model.goalkeeper,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
