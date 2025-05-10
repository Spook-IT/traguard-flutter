import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/create_player/data/create_player_repository.dart';
import 'package:traguard/features/create_player/domain/requests.dart';

part 'use_cases.g.dart';

/// A use case for creating a new player.
@riverpod
Future<void> createPlayer(Ref ref, {required CreatePlayerModel player}) {
  return ref.watch(createPlayerRepositoryProvider).createPlayer(player);
}
