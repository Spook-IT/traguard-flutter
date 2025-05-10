import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traguard/shared/models/player.dart';

part 'requests.freezed.dart';
part 'requests.g.dart';

/// This class represents the model for creating a new player.
@freezed
abstract class CreatePlayerModel with _$CreatePlayerModel {
  /// Creates a new instance of [CreatePlayerModel].
  const factory CreatePlayerModel({
    required String fullName,
    required int playerNumber,
    required PlayerRole playerRole,
    required PlayerStatus playerStatus,
    required int playerColorHex,
  }) = _CreatePlayerModel;

  /// Creates a new instance of [CreatePlayerModel] from JSON data.
  factory CreatePlayerModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePlayerModelFromJson(json);
}
