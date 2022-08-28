import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    required this.isSuccess,
    this.Message,
    this.accessCode,
    this.userId,
  });

  bool isSuccess;
  String? Message;
  int? accessCode;
  int? userId;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    isSuccess: json["IsSuccess"],
    Message: json["Message"],
    accessCode: json["access_code"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "IsSuccess": isSuccess,
    "Message": Message,
    "access_code": accessCode,
    "user_id": userId,
  };
}
