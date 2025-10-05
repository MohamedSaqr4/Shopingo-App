import 'package:ecommerce/core/api/api_end_points.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json[ApiKey.accessToken] ?? '',
      refreshToken: json[ApiKey.refreshToken] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.accessToken: accessToken,
      ApiKey.refreshToken: refreshToken,
    };
  }
}
