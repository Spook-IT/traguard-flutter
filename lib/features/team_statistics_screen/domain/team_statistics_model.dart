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

    /// The composition of players' roles in the team.
    /// This is represented by the [RoleCompositionModel] class.
    @Default(RoleCompositionModel()) RoleCompositionModel roleComposition,

    /// The weekly goals of the team.
    /// This is represented by the [WeeklyGoalsModel] class.
    @Default(WeeklyGoalsModel()) WeeklyGoalsModel weeklyGoals,

    /// The top athletes in the team.
    /// This is represented by the [TopAthleteModel] class.
    @Default([]) List<TopAthleteModel> topAthletes,

    /// The session trends of the team.
    /// It contains a list of [PlayerSessionTrendModel] for each player.
    @Default([]) List<PlayerSessionTrendModel> playerTrends,

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

/// A model class representing the composition of players' roles.
@freezed
abstract class RoleCompositionModel with _$RoleCompositionModel {
  /// Creates a new instance of [RoleCompositionModel].
  const factory RoleCompositionModel({
    @Default(0) int goalkeeper,
    @Default(0) int defender,
    @Default(0) int midfielder,
    @Default(0) int forward,
  }) = _RoleCompositionModel;

  /// Creates a new instance of [RoleCompositionModel] from JSON data.
  factory RoleCompositionModel.fromJson(Map<String, dynamic> json) =>
      _$RoleCompositionModelFromJson(json);

  const RoleCompositionModel._();

  /// Returns the total number of players in the team.
  int get totalPlayers => goalkeeper + defender + midfielder + forward;
}

/// A model class representing weekly goals.
/// This class contains information about [trainingIntensity],
/// [distanceTraveled], [precisionSteps], and [qualityRecovery].
@freezed
abstract class WeeklyGoalsModel with _$WeeklyGoalsModel {
  /// Creates a new instance of [WeeklyGoalsModel].
  const factory WeeklyGoalsModel({
    @Default(0) int trainingIntensity,
    @Default(0) int distanceTraveled,
    @Default(0) int precisionSteps,
    @Default(0) int qualityRecovery,
  }) = _WeeklyGoalsModel;

  /// Creates a new instance of [WeeklyGoalsModel] from JSON data.
  factory WeeklyGoalsModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyGoalsModelFromJson(json);
}

/// A model class representing the top athletes.
/// This class contains information about the [name], [role], and [value]
/// of the top athlete.
@freezed
abstract class TopAthleteModel with _$TopAthleteModel {
  /// Creates a new instance of [TopAthleteModel].
  const factory TopAthleteModel({
    @Default('') String name,
    @Default('') String role,
    @Default(0) double value,
  }) = _TopAthleteModel;

  /// Creates a new instance of [TopAthleteModel] from JSON data.
  factory TopAthleteModel.fromJson(Map<String, dynamic> json) =>
      _$TopAthleteModelFromJson(json);
}

/// A model class representing session trends.
/// This class contains information about the [sessionId],
/// [averageSpeed], [topSpeed], [distanceWalked], [firstHalfPercentagePresence],
/// [secondHalfPercentagePresence], and [performanceIndex].
///
/// - The [sessionId] is a unique identifier for the session.
/// - The [averageSpeed] and [topSpeed] are represented in `km/h`.
/// - The [distanceWalked] is represented in `km`.
/// - The [firstHalfPercentagePresence] and [secondHalfPercentagePresence]
///   are represented in percentage.
/// - The [performanceIndex] starts from `0` to `10`.
@freezed
abstract class SessionTrendModel with _$SessionTrendModel {
  /// Creates a new instance of [SessionTrendModel].
  const factory SessionTrendModel({
    required String sessionId,
    required String sessionName,
    @Default(0) double averageSpeed,
    @Default(0) double topSpeed,
    @Default(0) double distanceWalked,
    @Default(0) double firstHalfPercentagePresence,
    @Default(0) double secondHalfPercentagePresence,
    @Default(0) double performanceIndex,
  }) = _SessionTrendModel;

  /// Creates a new instance of [SessionTrendModel] from JSON data.
  factory SessionTrendModel.fromJson(Map<String, dynamic> json) =>
      _$SessionTrendModelFromJson(json);
}

/// A model class representing player session trends.
/// This class contains information about the [playerId], [playerName],
/// and a list of [trends].
@freezed
abstract class PlayerSessionTrendModel with _$PlayerSessionTrendModel {
  /// Creates a new instance of [PlayerSessionTrendModel].
  const factory PlayerSessionTrendModel({
    required String playerId,
    required String playerName,
    @Default([]) List<SessionTrendModel> trends,
  }) = _PlayerSessionTrendModel;

  /// Creates a new instance of [PlayerSessionTrendModel] from JSON data.
  factory PlayerSessionTrendModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerSessionTrendModelFromJson(json);
}
