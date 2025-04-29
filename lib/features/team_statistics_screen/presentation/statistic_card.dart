import 'package:flutter/material.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticCard extends StatelessWidget {
  /// Creates a new instance of [StatisticCard].
  const StatisticCard({
    required this.title,
    required this.statisticValue,
    required this.description,
    this.precision = 2,
    this.statisticUnit,
    this.bottomChild,
    super.key,
  });

  /// The title of the statistic card.
  final String title;

  /// The value of the statistic.
  final double statisticValue;

  /// The precision of the statistic value (optional).
  final int precision;

  /// The description of the statistic.
  final String description;

  /// The unit of the statistic value (optional).
  final String? statisticUnit;

  /// A widget to be displayed at the bottom of the card (optional).
  final Widget? bottomChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.largeAll,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: .3),
        ),
      ),
      child: Column(
        spacing: Spaces.small,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            spacing: Spaces.small,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                statisticValue.toFormattedPrecision(precision),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (statisticUnit != null) ...[Text(statisticUnit!)],
            ],
          ),
          Text(
            description,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: .5),
            ),
          ),
          if (bottomChild != null) ...[
            Spaces.tiny.sizedBoxHeight,
            bottomChild!,
          ],
        ],
      ),
    );
  }
}
