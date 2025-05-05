import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A base section card widget that provides a consistent design for sections
/// in the application.
class BaseSectionCard extends StatelessWidget {
  /// Creates a new instance of [BaseSectionCard].
  const BaseSectionCard({required this.child, this.title, super.key});

  /// The child widget to be displayed inside the card.
  final Widget child;

  /// The title of the card.
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Paddings.smallHorizontal,
      padding: Paddings.mediumAll,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spaces.large.sizedBoxHeight,
          ],
          child,
        ],
      ),
    );
  }
}
