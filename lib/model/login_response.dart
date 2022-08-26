// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_ecommerce/model/user_info.dart';

LoginResponse welcomeFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String welcomeToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.isSuccess,
    required this.info,
    required this.isVerified,
  });

  bool isSuccess;
  UserInfo info;
  bool isVerified;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        isSuccess: json["IsSuccess"],
        info: UserInfo.fromJson(json["info"]),
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "IsSuccess": isSuccess,
        "info": info.toJson(),
        "is_verified": isVerified,
      };
}
