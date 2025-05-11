import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/update_legal_data/domain/requests.dart';
import 'package:traguard/shared/providers/http_client.dart';

part 'update_legal_repository.g.dart';

/// A repository interface for updating legal data.
@RestApi(baseUrl: '/user')
abstract class UpdateLegalRepository {
  /// Creates a new instance of [UpdateLegalRepository].
  factory UpdateLegalRepository(Dio dio, {String baseUrl}) =
      _UpdateLegalRepository;

  /// Fetches the legal data.
  @GET('/legal-data')
  Future<LegalDataInfo> getLegalData();

  /// Updates the legal data.
  @POST('/legal-data')
  Future<void> updateLegalData(@Body() LegalDataInfo legalDataInfo);
}

/// A Riverpod provider for the [UpdateLegalRepository].
@riverpod
UpdateLegalRepository updateLegalRepository(Ref ref) {
  return MockUpdateLegalRepository(ref.watch(httpClientProvider));
}

// TODO(dariowskii): remove this mock repository
class MockUpdateLegalRepository implements UpdateLegalRepository {
  MockUpdateLegalRepository(Dio dio);

  @override
  Future<LegalDataInfo> getLegalData() {
    const model = LegalDataInfo(
      fullName: 'John Doe',
      email: 'john@mail.com',
      phone: '+1234567890',
    );
    return Future.delayed(const Duration(milliseconds: 300), () => model);
  }

  @override
  Future<void> updateLegalData(LegalDataInfo legalDataInfo) {
    return Future.delayed(const Duration(milliseconds: 500), () => null);
  }
}
