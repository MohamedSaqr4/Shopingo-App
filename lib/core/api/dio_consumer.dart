import 'package:dio/dio.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/errors/error_model.dart';
import 'package:ecommerce/core/errors/server_exceptions.dart'; 
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.receiveDataWhenStatusError = true;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  @override
  Future getRequest(
    String endPoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(
          messages: ['Unexpected error: $e'],
          error: e.runtimeType.toString(),
          statusCode: 0,
        ),
      );
    }
  }

  @override
  Future postRequest(
    String endPoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(
          messages: ['Unexpected error: $e'],
          error: e.runtimeType.toString(),
          statusCode: 0,
        ),
      );
    }
  }

  @override
  Future patchRequest(
    String endPoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        endPoint,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(
          messages: ['Unexpected error: $e'],
          error: e.runtimeType.toString(),
          statusCode: 0,
        ),
      );
    }
  }

  @override
  Future deleteRequest(
    String endPoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(
          messages: ['Unexpected error: $e'],
          error: e.runtimeType.toString(),
          statusCode: 0,
        ),
      );
    }
  }
}
