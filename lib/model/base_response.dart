import 'dart:convert';

CommonResponse baseResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String baseResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    required this.isSuccess,
    this.Message,
    this.ErrorCode,
  });

  bool isSuccess;
  String? Message;
  String? ErrorCode;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    isSuccess: json["IsSuccess"],
    Message: json["Message"],
    ErrorCode: json["ErrorCode"],
  );

  Map<String, dynamic> toJson() => {
    "IsSuccess": isSuccess,
    "Message": Message,
    "ErrorCode": ErrorCode,
  };
}
