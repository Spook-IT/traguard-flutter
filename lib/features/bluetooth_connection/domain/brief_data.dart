import 'package:freezed_annotation/freezed_annotation.dart';

part 'brief_data.freezed.dart';

/// An enum representing the state of a brief.
enum BriefState {
  /// The brief is not started yet.
  ready,

  /// The brief is in progress.
  recording,

  /// The brief is completed.
  end,

  /// The brief is in an unknown state.
  unknown,
}

/// A data class representing a brief.
/// It contains information about the start and end date, time, length,
/// ID, date text, and state of the brief.
@freezed
abstract class BriefData with _$BriefData {
  /// Creates a new instance of [BriefData].
  const factory BriefData({
    required int startDate,
    required int endDate,
    required int startTime,
    required int endTime,
    required int length,
    required int id,
    required BriefState state,
    required Duration duration,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) = _BriefData;
}
