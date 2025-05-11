import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traguard/features/update_legal_data/data/update_legal_repository.dart';
import 'package:traguard/features/update_legal_data/domain/requests.dart';

part 'use_cases.g.dart';

/// A use case for fetching legal data.
@riverpod
Future<LegalDataInfo> fetchLegalData(Ref ref) {
  return ref.watch(updateLegalRepositoryProvider).getLegalData();
}

/// A use case for updating legal data.
@riverpod
Future<void> updateLegalData(Ref ref, {required LegalDataInfo info}) {
  return ref.watch(updateLegalRepositoryProvider).updateLegalData(info);
}
