import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/authentication/data/repos/auth_repo.dart';
 import 'package:meta/meta.dart';
import 'package:ecommerce/features/authentication/data/models/login_response_model.dart';
import 'package:ecommerce/features/authentication/data/models/register_response_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final Either<String, LoginResponse> result =
        await repository.login(email: email, password: password);

    result.fold(
      (failureMessage) => emit(AuthFailure(failureMessage)), //left
      (loginResponse) => emit(LoginSuccess(loginResponse)), //right
    );
  }

  Future<void> register(
      {required String email,required String password,required String name,required String avatar}) async {
    emit(AuthLoading());

    final Either<String, RegisterResponse> result = await repository.register(
      email: email,
      password: password,
      name: name,
      avatar: avatar,
    );
    result.fold(
      (failureMessage) => emit(AuthFailure(failureMessage)),
      (registerResponse) => emit(RegisterSuccess(registerResponse)),
    );
  }
}
