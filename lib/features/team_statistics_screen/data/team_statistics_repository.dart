import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_session.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'team_statistics_repository.g.dart';

/// A repository interface for fetching team statistics data.
@RestApi(baseUrl: 'team/')
abstract class TeamStatisticsRepository {
  /// Creates an instance of [TeamStatisticsRepository].
  factory TeamStatisticsRepository(Dio dio, {String baseUrl}) =
      _TeamStatisticsRepository;

  /// Fetches the list of team sessions.
  @GET('/sessions')
  Future<TeamSessionListModel> getTeamSessions();

  /// Fetches the team statistics.
  @GET('/statistics')
  Future<TeamStatisticsModel> getTeamStatistics();
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
  Future<TeamSessionListModel> getTeamSessions() {
    final model = TeamSessionListModel(
      sessions: [
        TeamSessionModel(id: '1', date: DateTime(2023, 10), name: 'Sessione 1'),
        TeamSessionModel(
          id: '2',
          date: DateTime(2023, 10, 2),
          name: 'Sessione 2',
        ),
        TeamSessionModel(
          id: '3',
          date: DateTime(2023, 10, 3),
          name: 'Sessione 3',
        ),
        TeamSessionModel(
          id: '4',
          date: DateTime(2023, 10, 4),
          name: 'Sessione 4',
        ),
        TeamSessionModel(
          id: '5',
          date: DateTime(2023, 10, 5),
          name: 'Sessione 5',
        ),
      ],
    );

    return Future.delayed(const Duration(seconds: 1), () => model);
  }

  @override
  Future<TeamStatisticsModel> getTeamStatistics() {
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
      topAthletes: [
        TopAthleteModel(name: 'Mario Rossi', role: 'ATT', value: 8.9),
        TopAthleteModel(name: 'Giuseppe Verdi', role: 'CC', value: 8.5),
        TopAthleteModel(name: 'Marco Neri', role: 'POR', value: 8),
        TopAthleteModel(name: 'Antonio Blu', role: 'CC', value: 7.8),
        TopAthleteModel(name: 'Luca Gialli', role: 'DF', value: 7.5),
      ],
      playerTrends: [
        PlayerSessionTrendModel(
          playerId: '1',
          playerName: 'Mario Rossi',
          trends: [
            SessionTrendModel(
              sessionId: '1',
              sessionName: 'Sessione 1',
              averageSpeed: 25.5,
              topSpeed: 30.2,
              distanceWalked: 5.2,
              firstHalfPercentagePresence: 60,
              secondHalfPercentagePresence: 40,
              performanceIndex: 8.9,
            ),
            SessionTrendModel(
              sessionId: '2',
              sessionName: 'Sessione 2',
              averageSpeed: 26,
              topSpeed: 31,
              distanceWalked: 5.5,
              firstHalfPercentagePresence: 70,
              secondHalfPercentagePresence: 30,
              performanceIndex: 9,
            ),
            SessionTrendModel(
              sessionId: '3',
              sessionName: 'Sessione 3',
              averageSpeed: 24.8,
              topSpeed: 29.5,
              distanceWalked: 4.8,
              firstHalfPercentagePresence: 50,
              secondHalfPercentagePresence: 50,
              performanceIndex: 8.5,
            ),
            SessionTrendModel(
              sessionId: '4',
              sessionName: 'Sessione 4',
              averageSpeed: 25,
              topSpeed: 30,
              distanceWalked: 5,
              firstHalfPercentagePresence: 65,
              secondHalfPercentagePresence: 35,
              performanceIndex: 8.7,
            ),
            SessionTrendModel(
              sessionId: '5',
              sessionName: 'Sessione 5',
              averageSpeed: 26,
              topSpeed: 31.5,
              distanceWalked: 5.3,
              firstHalfPercentagePresence: 75,
              secondHalfPercentagePresence: 25,
              performanceIndex: 9.2,
            ),
          ],
        ),
        PlayerSessionTrendModel(
          playerId: '2',
          playerName: 'Giuseppe Verdi',
          trends: [
            SessionTrendModel(
              sessionId: '1',
              sessionName: 'Sessione 1',
              averageSpeed: 24.5,
              topSpeed: 29,
              distanceWalked: 4.5,
              firstHalfPercentagePresence: 55,
              secondHalfPercentagePresence: 45,
              performanceIndex: 8.2,
            ),
            SessionTrendModel(
              sessionId: '2',
              sessionName: 'Sessione 2',
              averageSpeed: 25,
              topSpeed: 30,
              distanceWalked: 4.8,
              firstHalfPercentagePresence: 65,
              secondHalfPercentagePresence: 35,
              performanceIndex: 8.5,
            ),
            SessionTrendModel(
              sessionId: '3',
              sessionName: 'Sessione 3',
              averageSpeed: 24,
              topSpeed: 28,
              distanceWalked: 4.2,
              firstHalfPercentagePresence: 50,
              secondHalfPercentagePresence: 50,
              performanceIndex: 8,
            ),
            SessionTrendModel(
              sessionId: '4',
              sessionName: 'Sessione 4',
              averageSpeed: 25.5,
              topSpeed: 30.5,
              distanceWalked: 4.7,
              firstHalfPercentagePresence: 70,
              secondHalfPercentagePresence: 30,
              performanceIndex: 8.8,
            ),
            SessionTrendModel(
              sessionId: '5',
              sessionName: 'Sessione 5',
              averageSpeed: 26,
              topSpeed: 31,
              distanceWalked: 5,
              firstHalfPercentagePresence: 80,
              secondHalfPercentagePresence: 20,
              performanceIndex: 9.1,
            ),
          ],
        ),
        PlayerSessionTrendModel(
          playerId: '3',
          playerName: 'Marco Neri',
          trends: [
            SessionTrendModel(
              sessionId: '1',
              sessionName: 'Sessione 1',
              averageSpeed: 23.5,
              topSpeed: 28,
              distanceWalked: 4,
              firstHalfPercentagePresence: 50,
              secondHalfPercentagePresence: 50,
              performanceIndex: 7.8,
            ),
            SessionTrendModel(
              sessionId: '2',
              sessionName: 'Sessione 2',
              averageSpeed: 24,
              topSpeed: 29,
              distanceWalked: 4.3,
              firstHalfPercentagePresence: 60,
              secondHalfPercentagePresence: 40,
              performanceIndex: 8.1,
            ),
            SessionTrendModel(
              sessionId: '3',
              sessionName: 'Sessione 3',
              averageSpeed: 23,
              topSpeed: 27.5,
              distanceWalked: 3.8,
              firstHalfPercentagePresence: 55,
              secondHalfPercentagePresence: 45,
              performanceIndex: 7.5,
            ),
            SessionTrendModel(
              sessionId: '4',
              sessionName: 'Sessione 4',
              averageSpeed: 24.5,
              topSpeed: 29.5,
              distanceWalked: 4.2,
              firstHalfPercentagePresence: 65,
              secondHalfPercentagePresence: 35,
              performanceIndex: 8.4,
            ),
            SessionTrendModel(
              sessionId: '5',
              sessionName: 'Sessione 5',
              averageSpeed: 25,
              topSpeed: 30,
              distanceWalked: 4.5,
              firstHalfPercentagePresence: 75,
              secondHalfPercentagePresence: 25,
              performanceIndex: 8.6,
            ),
          ],
        ),
        PlayerSessionTrendModel(
          playerId: '4',
          playerName: 'Antonio Blu',
          trends: [
            SessionTrendModel(
              sessionId: '1',
              sessionName: 'Sessione 1',
              averageSpeed: 22.5,
              topSpeed: 26,
              distanceWalked: 3.5,
              firstHalfPercentagePresence: 45,
              secondHalfPercentagePresence: 55,
              performanceIndex: 7.2,
            ),
            SessionTrendModel(
              sessionId: '2',
              sessionName: 'Sessione 2',
              averageSpeed: 23,
              topSpeed: 27,
              distanceWalked: 3.8,
              firstHalfPercentagePresence: 50,
              secondHalfPercentagePresence: 50,
              performanceIndex: 7.5,
            ),
            SessionTrendModel(
              sessionId: '3',
              sessionName: 'Sessione 3',
              averageSpeed: 22,
              topSpeed: 26,
              distanceWalked: 3.2,
              firstHalfPercentagePresence: 40,
              secondHalfPercentagePresence: 60,
              performanceIndex: 7,
            ),
            SessionTrendModel(
              sessionId: '4',
              sessionName: 'Sessione 4',
              averageSpeed: 23.5,
              topSpeed: 27.5,
              distanceWalked: 3.6,
              firstHalfPercentagePresence: 55,
              secondHalfPercentagePresence: 45,
              performanceIndex: 7.9,
            ),
            SessionTrendModel(
              sessionId: '5',
              sessionName: 'Sessione 5',
              averageSpeed: 24,
              topSpeed: 28,
              distanceWalked: 3.9,
              firstHalfPercentagePresence: 65,
              secondHalfPercentagePresence: 35,
              performanceIndex: 8.1,
            ),
          ],
        ),
        PlayerSessionTrendModel(
          playerId: '5',
          playerName: 'Luca Gialli',
          trends: [
            SessionTrendModel(
              sessionId: '1',
              sessionName: 'Sessione 1',
              averageSpeed: 21.5,
              topSpeed: 25,
              distanceWalked: 3,
              firstHalfPercentagePresence: 40,
              secondHalfPercentagePresence: 60,
              performanceIndex: 6.8,
            ),
            SessionTrendModel(
              sessionId: '2',
              sessionName: 'Sessione 2',
              averageSpeed: 22,
              topSpeed: 26,
              distanceWalked: 3.3,
              firstHalfPercentagePresence: 45,
              secondHalfPercentagePresence: 55,
              performanceIndex: 7.1,
            ),
            SessionTrendModel(
              sessionId: '3',
              sessionName: 'Sessione 3',
              averageSpeed: 21,
              topSpeed: 25,
              distanceWalked: 2.8,
              firstHalfPercentagePresence: 35,
              secondHalfPercentagePresence: 65,
              performanceIndex: 6.5,
            ),
            SessionTrendModel(
              sessionId: '4',
              sessionName: 'Sessione 4',
              averageSpeed: 22.5,
              topSpeed: 26.5,
              distanceWalked: 3.2,
              firstHalfPercentagePresence: 50,
              secondHalfPercentagePresence: 50,
              performanceIndex: 7.4,
            ),
            SessionTrendModel(
              sessionId: '5',
              sessionName: 'Sessione 5',
              averageSpeed: 23,
              topSpeed: 27,
              distanceWalked: 3.5,
              firstHalfPercentagePresence: 60,
              secondHalfPercentagePresence: 40,
              performanceIndex: 7.6,
            ),
          ],
        ),
      ],
      averageTeamSpeed: 26.4,
      totalDistance: 48.8,
      performanceIndex: 8,
    );
    return Future.delayed(const Duration(seconds: 1), () => model);
  }
}
