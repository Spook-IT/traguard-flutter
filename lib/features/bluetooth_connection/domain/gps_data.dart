import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_data.freezed.dart';
part 'gps_data.g.dart';

/// A data class representing GPS data.
/// It contains information about the [time], [latitude], and [longitude].
@freezed
abstract class GpsData with _$GpsData {
  /// Creates a new instance of [GpsData].
  const factory GpsData({
    required int time,
    required String latitude,
    required String longitude,
  }) = _GpsData;

  /// Creates a new instance of [GpsData] from JSON data.
  factory GpsData.fromJson(Map<String, dynamic> json) =>
      _$GpsDataFromJson(json);
}
