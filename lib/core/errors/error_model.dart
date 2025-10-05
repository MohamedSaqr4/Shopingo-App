import 'package:ecommerce/core/api/api_end_points.dart';

class ErrorModel {
  final List<String> messages;
  final String? error;
  final int statusCode;

  ErrorModel({
    required this.messages,
    this.error,
    required this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    final msg = json[ApiKey.message];
    List<String> parsedMessages;
    if (msg is String) {
      parsedMessages = [msg];
    } else if (msg is List) {
      parsedMessages = List<String>.from(msg);
      //thats mean parsedMessages = msg but with make sure all items is string
    } else {
      parsedMessages = ["Something went wrong"];
    }

    return ErrorModel(
      messages: parsedMessages,
      error: json[ApiKey.error],
      statusCode: json[ApiKey.statusCode] ,
    );
  }
}
