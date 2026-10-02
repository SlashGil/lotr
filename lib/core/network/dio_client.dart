import 'package:dio/dio.dart';

class DioClient {
  static const String baseUrl = 'https://the-one-api.dev/v2';
  static const String defaultApiKey = 'FK4gl53CZCA9cwUyBQw4';

  late final Dio _dio;

  DioClient({String? apiKey}) {
    final token = apiKey ?? defaultApiKey;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
