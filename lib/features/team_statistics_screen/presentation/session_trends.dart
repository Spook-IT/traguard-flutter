import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/features/team_statistics_screen/presentation/chart_statistic_card.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This enum represents the different filters available for the chart.
enum ChartFilter {
  /// Represents the average speed of the player.
  averageSpeed,

  /// Represents the top speed of the player.
  topSpeed,

  /// Represents the distance walked by the player.
  distanceWalked,

  /// Represents the percentage presence in the first half of the game.
  firstHalfPercentagePresence,

  /// Represents the percentage presence in the second half of the game.
  secondHalfPercentagePresence,

  /// Represents the performance index of the player.
  performanceIndex;

  /// Returns the name of the filter.
  String? get unit => switch (this) {
    averageSpeed || topSpeed => ' km/h',
    distanceWalked => ' km',
    firstHalfPercentagePresence => '%',
    secondHalfPercentagePresence => '%',
    _ => null,
  };
}

/// A widget that displays the session trends of players.
/// It shows a line chart comparing the performance of players
class SessionTrends extends StatefulWidget {
  /// Creates a new instance of [SessionTrends].
  const SessionTrends({required this.playerTrends, super.key});

  /// The list of player trends to be displayed in the chart.
  final List<PlayerSessionTrendModel> playerTrends;

  @override
  State<SessionTrends> createState() => _SessionTrendsState();
}

class _SessionTrendsState extends State<SessionTrends> {
  ChartFilter _selectedFilter = ChartFilter.averageSpeed;

  late List<Color> _colors = _setupColors();
  late List<String> _sessionNames = _setupSessionNames();

  late double _minValue = double.maxFinite;
  late double _maxValue = double.minPositive;

  List<double> _getYValues(PlayerSessionTrendModel player) {
    final allSessions = player.trends;

    return switch (_selectedFilter) {
      ChartFilter.averageSpeed =>
        allSessions.map((trend) => trend.averageSpeed).toList(),
      ChartFilter.topSpeed =>
        allSessions.map((trend) => trend.topSpeed).toList(),
      ChartFilter.distanceWalked =>
        allSessions.map((trend) => trend.distanceWalked).toList(),
      ChartFilter.firstHalfPercentagePresence =>
        allSessions.map((trend) => trend.firstHalfPercentagePresence).toList(),
      ChartFilter.secondHalfPercentagePresence =>
        allSessions.map((trend) => trend.secondHalfPercentagePresence).toList(),
      ChartFilter.performanceIndex =>
        allSessions.map((trend) => trend.performanceIndex).toList(),
    };
  }

  List<Color> _setupColors() {
    final colors = [...Colors.primaries]..shuffle();
    return List.generate(widget.playerTrends.length, (index) => colors[index]);
  }

  List<LineChartBarData> _setupLineBarsData() {
    return widget.playerTrends.indexed.map((player) {
      final yValues = _getYValues(player.$2);
      final sorted = [...yValues]..sort();
      _minValue = math.min(sorted.first, _minValue);
      _maxValue = math.max(sorted.last, _maxValue);

      return LineChartBarData(
        spots: List.generate(
          yValues.length,
          (index) => FlSpot(index.toDouble(), yValues[index]),
        ),
        color: _colors[player.$1],
        isCurved: true,
        barWidth: 3,
        isStrokeCapRound: true,
      );
    }).toList();
  }

  List<String> _setupSessionNames() {
    return widget.playerTrends.isNotEmpty
        ? widget.playerTrends.first.trends
            .map((trend) => trend.sessionName)
            .toList()
        : <String>[];
  }

  @override
  void didUpdateWidget(covariant SessionTrends oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playerTrends != widget.playerTrends) {
      _colors = _setupColors();
      _sessionNames = _setupSessionNames();
      _minValue = double.maxFinite;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localization

    _minValue = double.maxFinite;
    _maxValue = double.minPositive;

    final lineBarsData = _setupLineBarsData();

    return ChartStatisticCard(
      title: 'Trend Sessioni',
      description:
          'Confronto delle prestazioni degli atleti nelle diverse sessioni',
      child: Column(
        children: [
          DropdownMenu(
            menuStyle: const MenuStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              maximumSize: WidgetStatePropertyAll(Size.fromHeight(200)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            label: const Text('Metrica'),
            enableSearch: false,
            initialSelection: _selectedFilter,
            expandedInsets: Paddings.largeTop,
            onSelected: (value) {
              setState(() {
                _selectedFilter = value ?? ChartFilter.averageSpeed;
              });
            },
            dropdownMenuEntries:
                ChartFilter.values
                    .map((e) => DropdownMenuEntry(value: e, label: e.name))
                    .toList(),
          ),
          Spaces.large.sizedBoxHeight,
          AspectRatio(
            aspectRatio: 3 / 2,
            child: LineChart(
              duration: 500.ms,
              curve: Curves.decelerate,
              LineChartData(
                minY: _minValue - 3,
                maxY: _maxValue + 3,
                baselineY: 0,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    tooltipRoundedRadius: 8,
                    getTooltipColor: (_) => Colors.white,
                    tooltipBorder: const BorderSide(width: 0.5),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.indexed.map((touchedSpot) {
                        final player =
                            widget.playerTrends[touchedSpot.$2.barIndex];
                        final value = touchedSpot.$2.y;

                        final hasUnit = _selectedFilter.unit != null;

                        return LineTooltipItem(
                          player.playerName,
                          TextStyle(
                            color: _colors[touchedSpot.$1],
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: '\n${value.toFormattedPrecision(2)}',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: _colors[touchedSpot.$1],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (hasUnit) ...[
                              TextSpan(
                                text: '${_selectedFilter.unit}',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                  color: _colors[touchedSpot.$1],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      maxIncluded: false,
                      minIncluded: false,
                      getTitlesWidget: (value, meta) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            value.toFormattedPrecision(2),
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 8,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Padding(
                          padding: Paddings.mediumTop,
                          child: Transform.rotate(
                            angle: -(math.pi / 8),
                            child: Transform.translate(
                              offset: Offset(
                                index == 4 ? -8 : 0,
                                index == 4 ? -5 : 0,
                              ),
                              child: Text(
                                _sessionNames[index],
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                ),

                lineBarsData: lineBarsData,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
