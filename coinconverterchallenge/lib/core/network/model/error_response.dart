import 'api_error.dart';

class ErrorResponse {

  bool success;
  ApiError error;

  ErrorResponse({this.success, this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    success: json["success"],
    error: ApiError.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error.toJson(),
  };
}