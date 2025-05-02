// ignore_for_file: use_setters_to_change_properties .

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_session.dart';

part 'session_filter.freezed.dart';
part 'session_filter.g.dart';

/// This class represents the state of the session filter.
/// It can be in one of three states: [SessionFilterData], [SessionFilterEmpty],
/// or [SessionFilterLoading].
@freezed
sealed class SessionFilterState with _$SessionFilterState {
  /// Creates a new instance of [SessionFilterState].
  const factory SessionFilterState.data({
    required TeamSessionListModel sessions,
    TeamSessionModel? selectedSession,
  }) = SessionFilterData;

  const factory SessionFilterState.empty() = SessionFilterEmpty;
  const factory SessionFilterState.loading() = SessionFilterLoading;
}

/// This provider manages the state of the selected session filter.
@riverpod
class SessionFilter extends _$SessionFilter {
  @override
  SessionFilterState build() => const SessionFilterState.loading();

  /// Sets the selected session filter to the given [sessionModel].
  void setSessions(TeamSessionListModel sessionModel) {
    state = SessionFilterState.data(
      sessions: sessionModel,
      selectedSession: sessionModel.sessions.firstOrNull,
    );
  }

  /// Sets the selected session filter to the given [session].
  void setSelectedSession(TeamSessionModel session) {
    switch (state) {
      case SessionFilterData(:final sessions):
        state = SessionFilterState.data(
          sessions: sessions,
          selectedSession: session,
        );
      default:
    }
  }
}
