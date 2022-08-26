// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class UserInfo {
  UserInfo({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.thumbImage,
    required this.apiToken,
  });

  int id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String name;
  int phoneNumber;
  String image;
  String thumbImage;
  String apiToken;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        image: json["image"],
        thumbImage: json["thumb_image"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "name": name,
        "phone_number": phoneNumber,
        "image": image,
        "thumb_image": thumbImage,
        "api_token": apiToken,
      };
}
