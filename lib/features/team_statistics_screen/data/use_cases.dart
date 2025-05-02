import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/team_statistics_screen/data/session_filter.dart';
import 'package:traguard/features/team_statistics_screen/data/team_statistics_repository.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_session.dart';
import 'package:traguard/features/team_statistics_screen/domain/team_statistics_model.dart';

part 'use_cases.g.dart';

/// This provider fetches the team statistics data.
/// It uses the [TeamStatisticsRepository] to retrieve the data.
/// The data is fetched asynchronously and returns a [TeamStatisticsModel].
@riverpod
Future<TeamStatisticsModel> fetchStatistics(
  Ref ref, {
  required String sessionId,
}) {
  // TODO(dariowskii): use real teamId
  return ref
      .read(teamStatisticsRepositoryProvider)
      .getTeamStatistics(sessionId);
}

/// This provider fetches the team sessions data.
/// It uses the [TeamStatisticsRepository] to retrieve the data.
/// The data is fetched asynchronously and returns a [TeamSessionListModel].
@riverpod
Future<TeamSessionListModel> fetchTeamSessions(Ref ref) async {
  final response =
      await ref.read(teamStatisticsRepositoryProvider).getTeamSessions();
  ref.read(sessionFilterProvider.notifier).setSessions(response);
  return response;
}
