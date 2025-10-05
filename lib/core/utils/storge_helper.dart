 import 'package:ecommerce/core/api/api_end_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class StorgeHelper{
  
final FlutterSecureStorage storage = const FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true
  ),
);

Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(key: ApiKey.accessToken, value: accessToken);
    await storage.write(key: ApiKey.refreshToken, value: refreshToken);
  }

Future<String?> getAccessToken() async {
    return await storage.read(key: ApiKey.accessToken);
  }

Future<String?> getRefreshToken() async {
    return await storage.read(key: ApiKey.refreshToken);
  }

Future<void> clearTokens() async {
    await storage.delete(key: ApiKey.accessToken);
    await storage.delete(key: ApiKey.refreshToken);
  }

}
