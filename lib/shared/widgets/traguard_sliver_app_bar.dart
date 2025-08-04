import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:traguard/shared/utils/extensions.dart';

/// This widget is part of the team statistics feature of the application.
class TraguardSliverAppbar extends StatelessWidget {
  /// Creates a new instance of [TraguardSliverAppbar].
  const TraguardSliverAppbar({
    required this.title,
    required this.titleX,
    required this.titleY,
    required this.titleFactor,
    this.subtitleFactor,
    super.key,
    this.subtitle,
    this.showBackButton = true,
    this.actions,
  });

  /// The title of the app bar.
  final String title;

  /// The subtitle of the app bar.
  final String? subtitle;

  /// The max title on X axis.
  final double titleX;

  /// The max title on Y axis.
  final double titleY;

  /// The factor for the title size.
  final double titleFactor;

  /// The factor for the subtitle size.
  final double? subtitleFactor;

  /// Whether to show the back button.
  final bool showBackButton;

  /// Optional widgets displayed on the top-right corner.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StatisticsHeaderDelegate(
        title: title,
        subtitle: subtitle,
        titleX: titleX,
        titleY: titleY,
        titleFactor: titleFactor,
        subtitleFactor: subtitleFactor,
        showBackButton: showBackButton,
        actions: actions,
      ),
    );
  }
}

/// The actual header delegate for [TraguardSliverAppbar].
class StatisticsHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// Creates a new instance of [StatisticsHeaderDelegate].
  StatisticsHeaderDelegate({
    required this.title,
    required this.titleX,
    required this.titleY,
    required this.titleFactor,
    this.subtitleFactor,
    this.subtitle,
    this.showBackButton = true,
    this.actions,
  });

  /// The min extent of the app bar.
  late final double _maxExtent = minExtent + 80;

  /// The title of the app bar.
  final String title;

  /// The subtitle of the app bar.
  final String? subtitle;

  /// The max title on X axis.
  final double titleX;

  /// The max title on Y axis.
  final double titleY;

  /// The factor for the title size.
  final double titleFactor;

  /// The factor for the subtitle size.
  final double? subtitleFactor;

  /// Whether to show the back button.
  final bool showBackButton;

  /// Optional widgets displayed on the top-right corner.
  final List<Widget>? actions;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final factor = shrinkOffset / _maxExtent;

    final newTitleX = lerpDouble(titleX, 0, factor) ?? 0;
    final newTitleY = lerpDouble(titleY, 0, factor) ?? 0;

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
            if (showBackButton) const Positioned(child: BackButton()),
            if (actions != null)
              Positioned(
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                ),
              ),
            Align(
              alignment: Alignment(newTitleX, newTitleY),
              child: Column(
                crossAxisAlignment:
                    factor > 0.9
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title, //
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.textTheme.titleLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 24 - 24 * (factor * titleFactor),
                    ),
                  ),
                  if (subtitle != null && subtitleFactor != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.textTheme.titleLarge?.color,
                        fontSize:
                            16 - 16 * ((factor * factor) * subtitleFactor!),
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
