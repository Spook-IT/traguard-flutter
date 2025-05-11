import 'package:freezed_annotation/freezed_annotation.dart';

part 'requests.freezed.dart';
part 'requests.g.dart';

/// A request class for updating a team's legal data.
@freezed
abstract class TeamDataInfo with _$TeamDataInfo {
  /// Creates a new instance of [TeamDataInfo].
  const factory TeamDataInfo({
    required String teamName,
    required String teamLegalAddress,
    required String teamLegalEmail,
  }) = _TeamDataInfo;

  /// Creates a new instance of [TeamDataInfo] from JSON.
  factory TeamDataInfo.fromJson(Map<String, dynamic> json) =>
      _$TeamDataInfoFromJson(json);
}
