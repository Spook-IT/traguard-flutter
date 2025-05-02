import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_session.freezed.dart';
part 'team_session.g.dart';

/// A model class representing a team session.
/// This class contains information about the session's [id],
/// [date], and [name].
@freezed
abstract class TeamSession with _$TeamSession {
  /// Creates a new instance of [TeamSession].
  const factory TeamSession({
    required String id,
    required DateTime date,
    required String name,
  }) = _TeamSession;

  /// Creates a new instance of [TeamSession] from JSON data.
  factory TeamSession.fromJson(Map<String, dynamic> json) =>
      _$TeamSessionFromJson(json);
}
