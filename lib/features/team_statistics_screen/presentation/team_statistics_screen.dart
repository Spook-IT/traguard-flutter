import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/presentation/statistic_card.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsScreen extends StatelessWidget {
  /// Creates a new instance of [TeamStatisticsScreen].
  const TeamStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: Paddings.mediumAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Spaces.large,
            children: [
              Column(
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
              ),
              StatisticCard(
                title: 'Disponibilità atleti',
                statisticValue: '6',
                description: 'Attivi: 4, Infortunati: 1, Riposo: 1',
                bottomChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spaces.tiny,
                  children: [
                    LinearProgressIndicator(
                      value: 0.67,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: context.colorScheme.outline.withValues(
                        alpha: .3,
                      ),
                      color: context.textTheme.labelLarge?.color,
                    ),
                    Text(
                      '67% disponibili',
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const StatisticCard(
                title: 'Velocità Media Squadra',
                statisticValue: '26.4',
                statisticUnit: 'km/h',
                description: 'Ultima sessione',
              ),
              const StatisticCard(
                title: 'Distanza Totale',
                statisticValue: '48.8',
                statisticUnit: 'km',
                description: 'Ultima sessione',
              ),
              const StatisticCard(
                title: 'Indice Prestazione',
                statisticValue: '8.0',
                description: 'Media di scquadra per ultima sessione',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
