import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
/// It serves as a base class for creating statistic cards.
class BaseStatisticCard extends StatelessWidget {
  /// Creates a new instance of [BaseStatisticCard].
  const BaseStatisticCard({required this.child, super.key});

  /// The child widget to be displayed inside the card.
  final Widget child;

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
      child: child,
    );
  }
}
