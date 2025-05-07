// ignore_for_file: invalid_annotation_target .

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traguard/shared/utils/extensions.dart';

part 'player.freezed.dart';
part 'player.g.dart';

/// An enum representing the role of a player in a team.
enum PlayerRole {
  /// The player is a forward.
  forward,

  /// The player is a midfielder.
  midfielder,

  /// The player is a defender.
  defender,

  /// The player is a goalkeeper.
  goalkeeper,

  /// Unknown role.
  unknown;

  /// A method to get the label for the player's role.
  String getLabel(BuildContext context) => switch (this) {
    forward => context.l10n.forwards(1),
    midfielder => context.l10n.midfielders(1),
    defender => context.l10n.defenders(1),
    goalkeeper => context.l10n.goalkeepers(1),
    unknown => '',
  };
}

/// An enum representing the status of a player.
enum PlayerStatus {
  /// The player is active.
  active,

  /// The player is inactive.
  inactive,

  /// The player is injured.
  injured,

  /// Unknown status.
  unknown,
}

/// A class representing a player in a team.
/// It contains information about the player's [id], [name], [surname],
/// [playerNumber], [role], [status], and various performance metrics.
@freezed
abstract class Player with _$Player {
  /// Creates a new instance of [Player].
  const factory Player({
    required String id,
    required String name,
    required String surname,
    required int playerNumber,
    @JsonKey(unknownEnumValue: PlayerRole.unknown)
    @Default(PlayerRole.unknown)
    PlayerRole role,
    @JsonKey(unknownEnumValue: PlayerStatus.unknown)
    @Default(PlayerStatus.unknown)
    PlayerStatus status,
    double? averageSpeed,
    double? averageDistance,
    double? performanceIndex,
    int? uiColor,
  }) = _Player;

  /// Creates a new instance of [Player] from JSON data.
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  const Player._();

  /// A method to get the full name of the player.
  String get fullName => '$name $surname';
}
