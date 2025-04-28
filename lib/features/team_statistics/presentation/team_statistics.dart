import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics/presentation/statistic_card.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsPage extends StatelessWidget {
  /// Creates a new instance of [TeamStatisticsPage].
  const TeamStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: Paddings.mediumAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Gestione Squadra',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.textTheme.titleLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Statistiche e analisi di squadra'),
            Spaces.large.sizedBoxHeight,
            const StatisticCard(child: Text('Ultima sessione')),
            Spaces.large.sizedBoxHeight,
            StatisticCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disponibilità atleti',
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spaces.medium.sizedBoxHeight,
                  const Text('Statistiche di squadra'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
