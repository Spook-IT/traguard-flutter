import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget provides a shimmer effect for its child widget.
class BaseShimmer extends StatelessWidget {
  /// Creates a new instance of [BaseShimmer].
  const BaseShimmer({required this.child, super.key});

  /// The child widget to be wrapped with a shimmer effect.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: child,
    );
  }
}

/// This widget represents a shimmer container with
/// a specified height, width, and border radius.
class ShimmerContainer extends StatelessWidget {
  /// Creates a new instance of [ShimmerContainer].
  const ShimmerContainer({
    required this.height,
    required this.width,
    super.key,
    this.borderRadius = 8,
  });

  /// The height of the shimmer container.
  final double height;

  /// The width of the shimmer container.
  final double width;

  /// The border radius of the shimmer container.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
