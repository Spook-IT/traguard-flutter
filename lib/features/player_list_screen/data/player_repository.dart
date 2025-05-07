import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/player_list_screen/domain/response.dart';
import 'package:traguard/shared/models/player.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'player_repository.g.dart';

/// A repository interface for fetching player data from the API.
@RestApi()
abstract class PlayerRepository {
  /// Creates a new instance of [PlayerRepository].
  factory PlayerRepository(Dio dio, {String baseUrl}) = _PlayerRepository;

  /// Fetches a list of players from the API.
  @GET('/players')
  Future<PlayerListResponse> getPlayers({@Query('query') String? query});
}

/// A Riverpod provider for the [PlayerRepository].
@riverpod
PlayerRepository playerRepository(Ref ref) {
  // TODO(dariowskii): Implement the player repository
  return MockPlayerRepository(ref.watch(httpClientProvider));
}

class MockPlayerRepository implements PlayerRepository {
  MockPlayerRepository(Dio dio);

  @override
  Future<PlayerListResponse> getPlayers({String? query}) async {
    const players = [
      Player(
        id: '1',
        name: 'Mario',
        surname: 'Rossi',
        playerNumber: 10,
        role: PlayerRole.forward,
        status: PlayerStatus.active,
        averageSpeed: 32.5,
        averageDistance: 8.7,
        performanceIndex: 8.9,
        uiColor: 0xFFFF4136,
      ),
      Player(
        id: '2',
        name: 'Giuseppe',
        surname: 'Verdi',
        playerNumber: 7,
        role: PlayerRole.midfielder,
        status: PlayerStatus.active,
        averageSpeed: 28.3,
        averageDistance: 10.2,
        performanceIndex: 9.5,
        uiColor: 0xFF0074D9,
      ),
      Player(
        id: '3',
        name: 'Pietro',
        surname: 'Bianchi',
        playerNumber: 5,
        role: PlayerRole.defender,
        status: PlayerStatus.injured,
        averageSpeed: 25.1,
        averageDistance: 7.8,
        performanceIndex: 7.2,
        uiColor: 0xFF2FCC40,
      ),
      Player(
        id: '4',
        name: 'Marco',
        surname: 'Neri',
        playerNumber: 1,
        role: PlayerRole.goalkeeper,
        status: PlayerStatus.active,
        averageSpeed: 18.5,
        averageDistance: 4.2,
        performanceIndex: 8,
        uiColor: 0xFFFFDC00,
      ),
    ];

    final filteredPlayers =
        players.where((player) {
          if (query == null || query.isEmpty) {
            return true;
          }
          return player.fullName.contains(query.toLowerCase());
        }).toList();
    return Future.delayed(500.milliseconds, () {
      return PlayerListResponse(players: filteredPlayers);
    });
  }
}
