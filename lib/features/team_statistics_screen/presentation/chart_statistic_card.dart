import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/presentation/base_statistic_card.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
/// It serves as a card that displays a chart statistic
/// with a title and description.
class ChartStatisticCard extends StatelessWidget {
  /// Creates a new instance of [ChartStatisticCard].
  const ChartStatisticCard({
    required this.child,
    required this.title,
    required this.description,
    super.key,
  });

  /// The title of the chart statistic card.
  final String title;

  /// The description of the chart statistic card.
  final String description;

  /// The child widget to be displayed inside the card.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseStatisticCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spaces.tiny.sizedBoxHeight,
          Text(
            description,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: .5),
            ),
          ),
          Spaces.large.sizedBoxHeight,
          child,
        ],
      ),
    );
  }
}
