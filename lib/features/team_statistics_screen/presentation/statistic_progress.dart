import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// A widget that displays an statistic progress bar with
/// a title and a statistic value.
class StatisticProgress extends StatefulWidget {
  /// Creates a new instance of [StatisticProgress].
  const StatisticProgress({
    required this.title,
    required this.progressValue,
    required this.statisticValue,
    required this.color,
    this.statisticUnit,
    super.key,
  });

  /// The title of the progress bar.
  final Widget title;

  /// The progress value (between 0 and 1).
  final double progressValue;

  /// The color of the progress bar.
  final Color color;

  /// The value of the statistic.
  final int statisticValue;

  /// The unit of the statistic value (optional).
  final String? statisticUnit;

  @override
  State<StatisticProgress> createState() => _StatisticProgressState();
}

class _StatisticProgressState extends State<StatisticProgress> {
  String _formattedValue(int value) {
    return widget.statisticUnit != null
        ? '$value${widget.statisticUnit}'
        : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            widget.title,
            const Spacer(),
            Text(
              _formattedValue(widget.statisticValue),
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: widget.progressValue,
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
          backgroundColor: context.colorScheme.outline.withValues(alpha: .3),
          color: widget.color,
        ),
      ],
    );
  }
}
