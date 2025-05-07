import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/base_shimmer.dart';

/// This widget is part of the player list feature of the application.
/// It provides a loading state for the player list section.
class LoadingPlayers extends StatelessWidget {
  /// Creates a new instance of [LoadingPlayers].
  const LoadingPlayers({super.key});

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
            ShimmerContainer(height: 100, width: double.infinity),
            ShimmerContainer(height: 100, width: double.infinity),
            ShimmerContainer(height: 100, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
