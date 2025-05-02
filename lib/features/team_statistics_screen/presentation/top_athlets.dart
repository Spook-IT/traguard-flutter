import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/chart_statistic_card.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget is part of the team statistics feature of the application.
/// It displays the top athletes in the team.
class TopAthletes extends StatelessWidget {
  /// Creates a new instance of [TopAthletes].
  const TopAthletes({required this.athletes, super.key});

  /// The list of top athletes to be displayed.
  final List<TopAthleteModel> athletes;

  @override
  Widget build(BuildContext context) {
    return ChartStatisticCard(
      title: context.l10n.topAthletes,
      description: context.l10n.topAthletesSubtitle,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: athletes.length + 1,
        separatorBuilder:
            (context, index) =>
                Divider(height: 32, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    context.l10n.athletes(1),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    context.l10n.role,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    context.l10n.index,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            );
          }
          final athlete = athletes[index - 1];
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(athlete.name, style: context.textTheme.labelLarge),
              ),
              Expanded(
                child: Text(
                  athlete.role,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  athlete.value.toFormattedPrecision(1),
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
