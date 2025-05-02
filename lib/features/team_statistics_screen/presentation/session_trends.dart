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

  /// Returns the margin value for the filter.
  /// This value is used to adjust the y-axis of the chart.
  double get margin => switch (this) {
    averageSpeed || topSpeed => 3,
    firstHalfPercentagePresence => 5,
    secondHalfPercentagePresence => 5,
    performanceIndex || distanceWalked => 1,
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

  late List<({String playerId, Color color})> _colors = _setupColors();
  late List<String> _sessionNames = _setupSessionNames();
  late List<PlayerSessionTrendModel> _playerTrends = widget.playerTrends;

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

  List<({String playerId, Color color})> _setupColors() {
    final colors = [...Colors.primaries]..shuffle();
    return List.generate(widget.playerTrends.length, (index) {
      final player = widget.playerTrends[index];
      return (playerId: player.playerId, color: colors[index % colors.length]);
    });
  }

  Color _getColor(String playerId) {
    return _colors.where((e) => e.playerId == playerId).first.color;
  }

  List<LineChartBarData> _setupLineBarsData() {
    return _playerTrends.indexed.map((player) {
      final yValues = _getYValues(player.$2);
      final sorted = [...yValues]..sort();
      _minValue = math.min(sorted.first, _minValue);
      _maxValue = math.max(sorted.last, _maxValue);

      return LineChartBarData(
        spots: List.generate(
          yValues.length,
          (index) => FlSpot(index.toDouble(), yValues[index]),
        ),
        color: _getColor(player.$2.playerId),
        isCurved: true,
        barWidth: 3,
        isStrokeCapRound: true,
      );
    }).toList();
  }

  List<String> _setupSessionNames() {
    return _playerTrends.isNotEmpty
        ? _playerTrends.first.trends.map((trend) => trend.sessionName).toList()
        : <String>[];
  }

  List<FilterChip> _buildPlayersFilterChip() {
    return widget.playerTrends.indexed.map((player) {
      final playerName = player.$2.playerName;
      final playerColor = _getColor(player.$2.playerId);
      final isSelected = _playerTrends.any((p) => p.playerName == playerName);
      final textColor =
          playerColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

      final playerColorLight = playerColor.withValues(alpha: 0.2);

      return FilterChip(
        avatar: CircleAvatar(
          backgroundColor: isSelected ? playerColor : playerColorLight,
          foregroundColor: isSelected ? textColor : playerColor,
          child: Text(playerName[0].toUpperCase()),
        ),
        elevation: isSelected ? 3 : 0,
        showCheckmark: false,
        label: Text(playerName),
        selected: isSelected,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        selectedColor: playerColor.withValues(alpha: 0.3),
        backgroundColor: Colors.white,
        onSelected: (value) {
          if (_playerTrends.length == 1 && !value) {
            return;
          }
          setState(() {
            if (value) {
              _playerTrends = [
                ..._playerTrends,
                widget.playerTrends[player.$1],
              ];
            } else {
              _playerTrends =
                  _playerTrends
                      .where((p) => p.playerName != playerName)
                      .toList();
            }
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? playerColor : playerColorLight,
            width: 1.5,
          ),
        ),
      );
    }).toList();
  }

  @override
  void didUpdateWidget(covariant SessionTrends oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playerTrends != widget.playerTrends) {
      _playerTrends = widget.playerTrends;
      _colors = _setupColors();
      _sessionNames = _setupSessionNames();
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Atleti',
              style: context.textTheme.labelLarge,
              textAlign: TextAlign.start,
            ),
          ),
          Spaces.small.sizedBoxHeight,
          Wrap(spacing: 8, runSpacing: -5, children: _buildPlayersFilterChip()),
          Spaces.large.sizedBoxHeight,
          AspectRatio(
            aspectRatio: 3 / 2,
            child: LineChart(
              duration: 500.ms,
              curve: Curves.decelerate,
              LineChartData(
                minY: _minValue - _selectedFilter.margin,
                maxY: _maxValue + _selectedFilter.margin,
                baselineY: 0,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    tooltipRoundedRadius: 8,
                    getTooltipColor: (_) => Colors.white,
                    tooltipBorder: const BorderSide(width: 0.5),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.indexed.map((touchedSpot) {
                        final player = _playerTrends[touchedSpot.$2.barIndex];
                        final value = touchedSpot.$2.y;

                        final hasUnit = _selectedFilter.unit != null;

                        return LineTooltipItem(
                          player.playerName,
                          TextStyle(
                            color: _getColor(player.playerId),
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: '\n${value.toFormattedPrecision(2)}',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: _getColor(player.playerId),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (hasUnit) ...[
                              TextSpan(
                                text: '${_selectedFilter.unit}',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                  color: _getColor(player.playerId),
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
