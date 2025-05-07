import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/player_list_screen/data/player_repository.dart';
import 'package:traguard/features/player_list_screen/domain/response.dart';

part 'use_cases.g.dart';

/// A use case for fetching a list of players based on a query.
@riverpod
Future<PlayerListResponse> fetchPlayers(Ref ref, {String? query}) async {
  return ref.watch(playerRepositoryProvider).getPlayers(query: query);
}
