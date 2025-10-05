import 'package:dio/dio.dart';
import 'package:ecommerce/core/errors/error_model.dart';
 
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

ErrorModel handleDioException(DioException e) {
  final data = e.response?.data;  //  == my error

  ErrorModel safeError() {
    try {
      if (data != null && data is Map<String, dynamic>) {
        return ErrorModel.fromJson(data);
      }
      return ErrorModel(
        messages: [e.message ?? 'Unknown error'],
        error: 'DioError',
        statusCode: e.response?.statusCode ?? 0,
      );
    } catch (_) {
      return ErrorModel(
        messages: ['Failed to parse error response'],
        error: 'ParseError',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
    case DioExceptionType.badResponse:
      throw ServerException(errorModel: safeError());
    default:
      throw ServerException(
        errorModel: ErrorModel(
          messages: ['Unhandled Dio error: ${e.message}'],
          error: 'UnhandledError',
          statusCode: e.response?.statusCode ?? 0,
        ),
      );
  }
}
