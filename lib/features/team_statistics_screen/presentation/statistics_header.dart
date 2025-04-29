import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticsHeader extends StatelessWidget {
  /// Creates a new instance of [StatisticsHeader].
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.teamStatisticsTitle,
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(context.l10n.teamStatisticsSubtitle),
      ],
    );
  }
}
