import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:traguard/shared/utils/extensions.dart' hide DurationExtensions;
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the team statistics feature of the application.
class StatisticCard extends StatefulWidget {
  /// Creates a new instance of [StatisticCard].
  const StatisticCard({
    required this.title,
    required this.statisticValue,
    required this.description,
    this.precision = 2,
    this.statisticUnit,
    this.bottomChild,
    this.animationDelay = Duration.zero,
    super.key,
  });

  /// The title of the statistic card.
  final String title;

  /// The value of the statistic.
  final double statisticValue;

  /// The precision of the statistic value (optional).
  final int precision;

  /// The description of the statistic.
  final String description;

  /// The unit of the statistic value (optional).
  final String? statisticUnit;

  /// A widget to be displayed at the bottom of the card (optional).
  final Widget? bottomChild;

  /// The delay for the animation (optional).
  final Duration animationDelay;

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 3.seconds);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: Paddings.largeAll,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colorScheme.outline.withValues(alpha: .3),
            ),
          ),
          child: Column(
            spacing: Spaces.small,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: Spaces.small,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) {
                      return Text(
                        (_animation.value * widget.statisticValue)
                            .clamp(0, widget.statisticValue)
                            .toStringAsFixed(widget.precision),
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  if (widget.statisticUnit != null) ...[
                    Text(widget.statisticUnit!),
                  ],
                ],
              ),
              Text(
                widget.description,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: .5),
                ),
              ),
              if (widget.bottomChild != null) ...[
                Spaces.tiny.sizedBoxHeight,
                widget.bottomChild!,
              ],
            ],
          ),
        )
        .animate(
          delay: widget.animationDelay,
          onComplete: (_) {
            _controller.forward();
          },
        )
        .fadeIn(duration: 350.ms, curve: Curves.easeIn)
        .slideY(begin: 0.1, end: 0, duration: 350.ms);
  }
}
