import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
