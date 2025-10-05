import 'package:ecommerce/core/api/api_end_points.dart';

class RegisterResponse {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String creationAt;
  final String updatedAt;

  RegisterResponse({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json[ApiKey.id] ?? 0,
      email: json[ApiKey.email] ?? '',
      password: json[ApiKey.password] ?? '',
      name: json[ApiKey.name] ?? '',
      role: json[ApiKey.role] ?? '',
      avatar: json[ApiKey.avatar] ?? '',
      creationAt: json[ApiKey.creationAt] ?? '',
      updatedAt: json[ApiKey.updatedAt] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.email: email,
      ApiKey.password: password,
      ApiKey.name: name,
      ApiKey.role: role,
      ApiKey.avatar: avatar,
      ApiKey.creationAt: creationAt,
      ApiKey.updatedAt: updatedAt,
    };
  }
}
