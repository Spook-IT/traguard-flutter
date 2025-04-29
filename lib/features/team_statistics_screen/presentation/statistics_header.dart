import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticsHeader extends StatelessWidget {
  /// Creates a new instance of [StatisticsHeader].
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gestione Squadra',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text('Statistiche e analisi di squadra'),
      ],
    );
  }
}
