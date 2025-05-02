import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// A widget that displays a linear progress.
/// It is used to show the progress of a task or operation.
class CommonLinearProgress extends StatelessWidget {
  /// Creates a new instance of [CommonLinearProgress].
  const CommonLinearProgress({required this.value, super.key, this.color});

  /// The progress value, ranging from 0.0 to 1.0.
  final double value;

  /// The color of the progress indicator.
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
