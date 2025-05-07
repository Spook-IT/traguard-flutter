import 'package:flutter/material.dart';
import 'package:traguard/shared/models/player.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';

/// A widget that represents a card displaying player information.
/// It is used to show player details in the player list screen.
class PlayerCard extends StatelessWidget {
  /// Creates a new instance of [PlayerCard].
  const PlayerCard({required this.player, super.key});

  /// The player to be displayed in the card.
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: .3),
        ),
      ),
      child: Row(
        spacing: Spaces.medium,
        children: [
          Container(
            height: 40,
            width: 8,
            decoration: BoxDecoration(
              color: Color(player.uiColor ?? 0xFF000000),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(player.uiColor ?? 0xFF000000),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                player.fullName.initials,
                style: context.textTheme.titleMedium,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spaces.tiny,
            children: [
              Row(
                spacing: Spaces.small,
                children: [
                  Text(
                    player.fullName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '#${player.playerNumber}',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: Spaces.tiny,
                children: [
                  Container(
                    padding: Paddings.tinyAll + Paddings.tinyHorizontal,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colorScheme.outline.withValues(
                          alpha: .3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      player.role.getLabel(context),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: Paddings.tinyAll + Paddings.tinyHorizontal,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: player.status.bgColor,
                    ),
                    child: Text(
                      player.status.getLabel(context),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: player.status.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
