part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginResponse loginResponse;
  LoginSuccess(this.loginResponse);
}

final class RegisterSuccess extends AuthState {
  final RegisterResponse registerResponse;
  RegisterSuccess(this.registerResponse);
}

 final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
