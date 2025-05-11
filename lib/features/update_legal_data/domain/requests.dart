import 'package:freezed_annotation/freezed_annotation.dart';

part 'requests.freezed.dart';
part 'requests.g.dart';

/// A request class for updating legal data.
/// It contains fields for the [fullName], [email], and [phone] of the user.
@freezed
abstract class LegalDataInfo with _$LegalDataInfo {
  /// Creates a new instance of [LegalDataInfo].
  const factory LegalDataInfo({
    required String fullName,
    required String email,
    required String phone,
  }) = _LegalDataInfo;

  /// Creates a new instance of [LegalDataInfo] from JSON.
  factory LegalDataInfo.fromJson(Map<String, dynamic> json) =>
      _$LegalDataInfoFromJson(json);
}
