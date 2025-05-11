import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_shimmer.dart';

/// This widget is part of the update team data feature of the application.
/// It provides a loading state for the team data section.
class LoadingTeam extends StatelessWidget {
  /// Creates a new instance of [LoadingTeam].
  const LoadingTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.mediumAll,
      child: const BaseShimmer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spaces.small,
          children: [
            ShimmerContainer(
              height: 60,
              width: double.infinity,
              borderRadius: 16,
            ),
            ShimmerContainer(
              height: 60,
              width: double.infinity,
              borderRadius: 16,
            ),
            ShimmerContainer(
              height: 60,
              width: double.infinity,
              borderRadius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
