import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traguard/shared/utils/assets.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

class ErrorRetry extends StatelessWidget {
  const ErrorRetry({super.key, this.error, this.onRetry});

  final Object? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final errorTitle = context.l10n.genericError;
    final errorSubtitle = error?.toString() ?? context.l10n.retryLater;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Spaces.large,
      children: [
        LottieBuilder.asset(
          LottieAssets.error.path,
          frameRate: FrameRate.max,
          width: 80,
          height: 80,
          repeat: false,
        ),
        Column(
          spacing: Spaces.small,
          children: [
            Text(
              errorTitle,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              errorSubtitle,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        if (onRetry != null) ...[
          FilledButton(
            onPressed: onRetry,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                context.textTheme.labelLarge?.color,
              ),
            ),
            child: Text(context.l10n.retry),
          ),
        ],
      ],
    );
  }
}
