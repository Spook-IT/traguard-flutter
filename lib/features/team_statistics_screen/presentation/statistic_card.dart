import 'package:flutter/material.dart';
import 'package:traguard/utils/extensions.dart';
import 'package:traguard/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticCard extends StatelessWidget {
  /// Creates a new instance of [StatisticCard].
  const StatisticCard({required this.child, super.key});

  /// The child widget to be displayed inside the card.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.mediumAll,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: child,
    );
  }
}
