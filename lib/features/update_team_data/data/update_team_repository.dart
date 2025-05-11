import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/update_team_data/domain/requests.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'update_team_repository.g.dart';

/// A repository interface for updating legal data.
@RestApi(baseUrl: '/user')
abstract class UpdateTeamRepository {
  /// Creates a new instance of [UpdateTeamRepository].
  factory UpdateTeamRepository(Dio dio, {String baseUrl}) =
      _UpdateTeamRepository;

  /// Fetches the team data.
  @GET('/team-data')
  Future<TeamDataInfo> getTeamData();

  /// Updates the team data.
  @POST('/team-data')
  Future<void> updateTeamData(@Body() TeamDataInfo teamDataInfo);
}

/// A Riverpod provider for the [UpdateTeamRepository].
@riverpod
UpdateTeamRepository updateTeamRepository(Ref ref) {
  return MockUpdateTeamRepo(ref.watch(httpClientProvider));
}

// TODO(dariowskii): remove this mock repository
class MockUpdateTeamRepo implements UpdateTeamRepository {
  MockUpdateTeamRepo(Dio dio);

  @override
  Future<TeamDataInfo> getTeamData() {
    const model = TeamDataInfo(
      teamName: 'Modena FC',
      teamLegalAddress: 'Via Emilia Est, 123',
      teamLegalEmail: 'modenafc@mail.com',
    );
    return Future.delayed(const Duration(milliseconds: 300), () => model);
  }

  @override
  Future<void> updateTeamData(TeamDataInfo teamDataInfo) {
    return Future.delayed(const Duration(milliseconds: 500), () => null);
  }
}
