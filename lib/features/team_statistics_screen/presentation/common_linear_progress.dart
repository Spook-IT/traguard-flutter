import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

class CommonLinearProgress extends StatelessWidget {
  const CommonLinearProgress({required this.value, super.key, this.color});

  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: 8,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: context.colorScheme.outline.withValues(alpha: .1),
      color: color,
    );
  }
}
