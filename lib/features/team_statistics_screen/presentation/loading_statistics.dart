import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_shimmer.dart';

/// This widget is part of the team statistics feature of the application.
/// It provides a loading state for the statistics section.
class LoadingStatistics extends StatelessWidget {
  /// Creates a new instance of [LoadingStatistics].
  const LoadingStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.mediumAll,
      child: const BaseShimmer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spaces.large,
          children: [
            ShimmerContainer(height: 200, width: double.infinity),
            ShimmerContainer(height: 130, width: double.infinity),
            ShimmerContainer(height: 130, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
