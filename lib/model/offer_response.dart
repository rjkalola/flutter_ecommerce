import 'dart:convert';

import 'package:flutter_ecommerce/model/offer_info.dart';

import 'slider_info.dart';
import 'category_info.dart';
import 'product_info.dart';

OfferResponse OfferResponseFromJson(String str) =>
    OfferResponse.fromJson(json.decode(str));

class OfferResponse {
  OfferResponse({
    required this.isSuccess,
    this.Data,
    this.Message,
    this.ErrorCode,
    required this.offset,
  });

  OfferResponse.fromJson(dynamic json) {
    isSuccess = json['IsSuccess'];
    if (json['Data'] != null) {
      Data = [];
      json['Data'].forEach((v) {
        Data?.add(OfferInfo.fromJson(v));
      });
    }
    if (json['Message'] != null) {
      Message = json['Message'];
    }
    if (json['ErrorCode'] != null) {
      ErrorCode = json['ErrorCode'];
    }

    offset = json['offset'];
  }

  bool isSuccess = false;
  String? Message;
  String? ErrorCode;
  List<OfferInfo>? Data;
  int offset = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsSuccess'] = isSuccess;
    if (Data != null) {
      map['products'] = Data?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    return map;
  }
}
