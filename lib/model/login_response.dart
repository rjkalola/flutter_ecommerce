// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_ecommerce/model/user_info.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String welcomeToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({required this.isSuccess,
    required this.info,
    required this.isVerified,
    this.Message,
    this.user_id,
    this.code});

  bool isSuccess;
  UserInfo? info;
  bool? isVerified;
  String? Message;
  int? user_id;
  String? code;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        isSuccess: json["IsSuccess"],
        info: json["info"] == null ? null : UserInfo.fromJson(json["info"]),
        isVerified: json["is_verified"],
        Message: json["Message"],
        user_id: json["user_id"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() =>
      {
        "IsSuccess": isSuccess,
        "info": info?.toJson(),
        "is_verified": isVerified,
        "Message": Message,
        "user_id": user_id,
        "code": code,
      };
}
