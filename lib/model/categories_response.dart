import 'dart:convert';

import 'package:flutter_ecommerce/model/category_info.dart';
import 'package:flutter_ecommerce/model/offer_info.dart';

CategoriesResponse categoriesResponseFromJson(String str) =>
    CategoriesResponse.fromJson(json.decode(str));

class CategoriesResponse {
  CategoriesResponse({
    required this.isSuccess,
    this.info,
    this.Message,
    this.ErrorCode,
  });

  CategoriesResponse.fromJson(dynamic json) {
    isSuccess = json['IsSuccess'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info?.add(CategoryInfo.fromJson(v));
      });
    }
    if (json['Message'] != null) {
      Message = json['Message'];
    }
    if (json['ErrorCode'] != null) {
      ErrorCode = json['ErrorCode'];
    }

  }

  bool isSuccess = false;
  String? Message;
  String? ErrorCode;
  List<CategoryInfo>? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsSuccess'] = isSuccess;
    if (info != null) {
      map['Data'] = info?.map((v) => v.toJson()).toList();
    }
    if (Message != null) {
      map['Message'] = Message;
    }
    if (ErrorCode != null) {
      map['ErrorCode'] = ErrorCode;
    }
    return map;
  }
}
