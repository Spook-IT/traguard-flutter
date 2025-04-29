import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client.g.dart';

/// A generic HTTP client for making network requests.
@riverpod
Dio httpClient(Ref ref) {
  final client = Dio();

  // TODO(dariowskii): setup base url

  client.interceptors.add(
    LogInterceptor(responseBody: true, requestBody: true),
  );

  return client;
}
