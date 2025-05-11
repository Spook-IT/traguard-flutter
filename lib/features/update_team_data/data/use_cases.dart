import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/update_team_data/data/update_team_repository.dart';
import 'package:traguard/features/update_team_data/domain/requests.dart';

part 'use_cases.g.dart';

/// A use case for fetching team data.
@riverpod
Future<TeamDataInfo> fetchTeamData(Ref ref) {
  return ref.watch(updateTeamRepositoryProvider).getTeamData();
}

/// A use case for updating team data.
@riverpod
Future<void> updateTeamData(Ref ref, {required TeamDataInfo info}) {
  return ref.watch(updateTeamRepositoryProvider).updateTeamData(info);
}
