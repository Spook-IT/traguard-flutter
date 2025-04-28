import 'package:flutter/material.dart';

/// This widget is part of the team statistics feature of the application.
class TeamStatisticsPage extends StatelessWidget {
  /// Creates a new instance of [TeamStatisticsPage].
  const TeamStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Statistics')),
      body: const Center(child: Text('Team Statistics Screen')),
    );
  }
}
