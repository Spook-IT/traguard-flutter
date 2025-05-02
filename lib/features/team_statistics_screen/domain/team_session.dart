import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_session.freezed.dart';
part 'team_session.g.dart';

/// A model class representing a list of team sessions.
@freezed
abstract class TeamSessionListModel with _$TeamSessionListModel {
  /// Creates a new instance of [TeamSessionListModel].
  const factory TeamSessionListModel({
    required List<TeamSessionModel> sessions,
  }) = _TeamSessionListModel;

  /// Creates a new instance of [TeamSessionListModel] from JSON data.
  factory TeamSessionListModel.fromJson(Map<String, dynamic> json) =>
      _$TeamSessionListModelFromJson(json);
}

/// A model class representing a team session.
/// This class contains information about the session's [id],
/// [date], and [name].
@freezed
abstract class TeamSessionModel with _$TeamSessionModel {
  /// Creates a new instance of [TeamSessionModel].
  const factory TeamSessionModel({
    required String id,
    required DateTime date,
    required String name,
  }) = _TeamSessionModel;

  /// Creates a new instance of [TeamSessionModel] from JSON data.
  factory TeamSessionModel.fromJson(Map<String, dynamic> json) =>
      _$TeamSessionModelFromJson(json);
}
