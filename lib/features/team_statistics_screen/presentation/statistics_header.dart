import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticsHeader extends StatelessWidget {
  /// Creates a new instance of [StatisticsHeader].
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StatisticsHeaderDelegate(),
    );
  }
}

/// The actual header delegate for [StatisticsHeader].
class StatisticsHeaderDelegate extends SliverPersistentHeaderDelegate {
  late final double _maxExtent = minExtent + 80;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final factor = shrinkOffset / _maxExtent;

    final titleX = lerpDouble(-.75, 0, factor) ?? 0;
    final titleY = lerpDouble(.95, 0, factor) ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: factor),
        boxShadow:
            factor > 0.9
                ? [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    color: Colors.black12.withValues(
                      alpha: factor.clamp(0, 0.12),
                    ),
                    blurRadius: 6,
                  ),
                ]
                : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned(child: BackButton()),
            Align(
              alignment: Alignment(titleX, titleY),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.teamStatisticsTitle,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.textTheme.titleLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 24 - 24 * (factor * 0.15),
                    ),
                  ),
                  if (factor < 0.3) ...[
                    Text(
                      context.l10n.teamStatisticsSubtitle,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.textTheme.titleLarge?.color,
                        fontSize: 16 - 16 * (factor * 0.35),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent =>
      MediaQueryData.fromView(
        ui.PlatformDispatcher.instance.implicitView!,
      ).padding.top +
      kToolbarHeight;

  @override
  bool shouldRebuild(covariant StatisticsHeaderDelegate oldDelegate) => false;
}
