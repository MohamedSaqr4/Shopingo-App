import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/api/api_consumer.dart';
import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:ecommerce/core/errors/server_exceptions.dart';
import 'package:ecommerce/core/service_locator/service_locator.dart';
import 'package:ecommerce/core/utils/storge_helper.dart';
import 'package:ecommerce/features/authentication/data/models/login_response_model.dart';
import 'package:ecommerce/features/authentication/data/models/register_response_model.dart';
 
class AuthRepository {
  final ApiConsumer api;
  AuthRepository(this.api,);
  
  Future<Either<String, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.postRequest(
        EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response == null) {
        return const Left("No response from server");
      }
      final loginResponse = LoginResponse.fromJson(response);
       await sl<StorgeHelper>().saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      return Right(loginResponse);

    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
    } catch (e) {
      return Left('Unexpected error in AuthRepository.login: $e');
    }
  }

  Future<Either<String, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    try {
      final response = await api.postRequest(
        EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatar,
        },
      );
      if (response == null) {
        return const Left("No response from server");
      }
      return Right(RegisterResponse.fromJson(response));

    } on ServerException catch (e) {
      return Left(e.errorModel.messages.join(", "));
      
    } catch (e) {
      return Left('Unexpected error in AuthRepository.register: $e');
    }
  }
}
