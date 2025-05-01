import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';

/// This widget is part of the team statistics feature of the application.
/// It displays the top athletes in the team.
class TopAthletes extends StatelessWidget {
  /// Creates a new instance of [TopAthletes].
  const TopAthletes({required this.athletes, super.key});

  /// The list of top athletes to be displayed.
  final List<TopAthleteModel> athletes;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
