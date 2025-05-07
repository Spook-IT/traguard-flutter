import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traguard/features/player_list_screen/data/use_cases.dart';
import 'package:traguard/features/player_list_screen/presentation/loading_players.dart';
import 'package:traguard/features/player_list_screen/presentation/player_card.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// This widget is part of the player list feature of the application.
/// It displays a list of players based on the provided query.
class PlayerListBody extends ConsumerWidget {
  /// Creates a new instance of [PlayerListBody].
  const PlayerListBody({super.key, this.query});

  /// The query string used to filter the list of players.
  final String? query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(fetchPlayersProvider(query: query));
    return switch (playersAsync) {
      AsyncData(:final value) => SliverToBoxAdapter(
        child: SafeArea(
          top: false,
          child: ListView.separated(
            itemCount: value.players.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding:
                Paddings.mediumHorizontal +
                Paddings.smallVertical +
                Paddings.xLargeBottom * 3,
            separatorBuilder: (_, _) => Spaces.medium.sizedBoxHeight,
            itemBuilder: (context, index) {
              final player = value.players[index];
              return PlayerCard(player: player);
            },
          ),
        ),
      ),
      AsyncError(:final error) => SliverToBoxAdapter(
        child: Center(
          child: Text(error.toString(), style: context.textTheme.bodyLarge),
        ),
      ),
      _ => const SliverToBoxAdapter(child: LoadingPlayers()),
    };
  }
}
