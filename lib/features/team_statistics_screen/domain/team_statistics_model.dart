import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_statistics_model.freezed.dart';
part 'team_statistics_model.g.dart';

/// A model class representing team statistics.
/// This class contains information about [playersAvailability],
/// [averageTeamSpeed], [totalDistance], and [performanceIndex].
@freezed
abstract class TeamStatisticsModel with _$TeamStatisticsModel {
  /// Creates a new instance of [TeamStatisticsModel].
  const factory TeamStatisticsModel({
    /// The availability of players in the team.
    /// This is represented by the [PlayersAvailabilityModel] class.
    @Default(PlayersAvailabilityModel())
    PlayersAvailabilityModel playersAvailability,

    /// The average speed of the team.
    /// This value is represented in `km/h`.
    @Default(0) double averageTeamSpeed,

    /// The total distance covered by the team.
    /// This value is represented in `km`.
    @Default(0) double totalDistance,

    /// The performance index of the team.
    /// This value starts from `0` to `10`.
    @Default(0) double performanceIndex,
  }) = _TeamStatisticsModel;

  /// Creates a new instance of [TeamStatisticsModel] from JSON data.
  factory TeamStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$TeamStatisticsModelFromJson(json);
}

/// A model class representing players' availability.
/// This class contains information about the number of [activePlayers],
/// [injuredPlayers], and [restPlayers].
/// The [availabilityPercentage] represents the percentage of players available.
/// It also provides a method to calculate the [totalPlayers].
@freezed
abstract class PlayersAvailabilityModel with _$PlayersAvailabilityModel {
  /// Creates a new instance of [PlayersAvailabilityModel].
  const factory PlayersAvailabilityModel({
    @Default(0) int activePlayers,
    @Default(0) int injuredPlayers,
    @Default(0) int restPlayers,
    @Default(0) int availabilityPercentage,
  }) = _PlayersAvailabilityModel;

  /// Creates a new instance of [PlayersAvailabilityModel] from JSON data.
  factory PlayersAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$PlayersAvailabilityModelFromJson(json);

  const PlayersAvailabilityModel._();

  /// Returns the total number of players.
  int get totalPlayers => activePlayers + injuredPlayers + restPlayers;
}
