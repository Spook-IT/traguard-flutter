import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traguard/utils/assets.dart';
import 'package:traguard/utils/extensions.dart';

/// A widget that displays a searching animation.
class SearchingAnimation extends StatelessWidget {
  /// Creates a new instance of [SearchingAnimation].
  const SearchingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.shortestSide,
      child: Center(
        child: Lottie.asset(
          LottieAssets.bluetoothSearch.path,
          alignment: Alignment.center,
          repeat: true,
        ),
      ),
    );
  }
}
