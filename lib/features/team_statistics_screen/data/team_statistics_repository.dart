import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'team_statistics_repository.g.dart';

/// A repository interface for fetching team statistics data.
@RestApi(baseUrl: 'team/')
abstract class TeamStatisticsRepository {
  /// Creates an instance of [TeamStatisticsRepository].
  factory TeamStatisticsRepository(Dio dio, {String baseUrl}) =
      _TeamStatisticsRepository;

  /// Fetches the team statistics for a given [teamId].
  @GET('{teamId}/statistics')
  Future<TeamStatisticsModel> getTeamStatistics({
    @Path() required String teamId,
  });
}

/// A Riverpod provider for the [TeamStatisticsRepository].
@riverpod
TeamStatisticsRepository teamStatisticsRepository(Ref ref) {
  return MockTeamStatisticsRepository(ref.watch(httpClientProvider));
}

// TODO(dariowskii): remove this mock repository

class MockTeamStatisticsRepository implements TeamStatisticsRepository {
  MockTeamStatisticsRepository(Dio dio);
  @override
  Future<TeamStatisticsModel> getTeamStatistics({required String teamId}) {
    const model = TeamStatisticsModel(
      playersAvailability: PlayersAvailabilityModel(
        activePlayers: 4,
        injuredPlayers: 1,
        restPlayers: 1,
        availabilityPercentage: 67,
      ),
      roleComposition: RoleCompositionModel(
        forward: 1,
        defender: 2,
        midfielder: 2,
        goalkeeper: 1,
      ),
      weeklyGoals: WeeklyGoalsModel(
        trainingIntensity: 85,
        distanceTraveled: 62,
        precisionSteps: 78,
        qualityRecovery: 90,
      ),
      averageTeamSpeed: 26.4,
      totalDistance: 48.8,
      performanceIndex: 8,
    );
    return Future.delayed(const Duration(seconds: 1), () => model);
  }
}
