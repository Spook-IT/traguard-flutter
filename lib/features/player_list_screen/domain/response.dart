import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traguard/shared/models/player.dart';

part 'response.freezed.dart';
part 'response.g.dart';

/// A class representing a response containing a list of players.
/// It contains a list of [Player] objects.
@freezed
abstract class PlayerListResponse with _$PlayerListResponse {
  /// Creates a new instance of [PlayerListResponse].
  const factory PlayerListResponse({@Default([]) List<Player> players}) =
      _PlayerListResponse;

  /// Creates a new instance of [PlayerListResponse] from JSON data.
  factory PlayerListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerListResponseFromJson(json);
}
