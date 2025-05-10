import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/create_player/domain/requests.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'create_player_repository.g.dart';

/// A repository interface for creating a new player in the API.
@RestApi()
abstract class CreatePlayerRepository {
  /// Creates a new instance of [CreatePlayerRepository].
  factory CreatePlayerRepository(Dio dio, {String baseUrl}) =
      _CreatePlayerRepository;

  /// Creates a new player in the API.
  /// [player] is the model containing the player's data.
  @POST('/players')
  Future<void> createPlayer(@Body() CreatePlayerModel player);
}

/// A Riverpod provider for the [CreatePlayerRepository].
@riverpod
CreatePlayerRepository createPlayerRepository(Ref ref) {
  // TODO(dariowskii): Implement the player repository
  return MockCreate(ref.watch(httpClientProvider));
}

// TODO(dariowskii): remove mock

class MockCreate implements CreatePlayerRepository {
  const MockCreate(Dio dio);

  @override
  Future<void> createPlayer(CreatePlayerModel player) async {
    // Simulate a network delay
    return Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
