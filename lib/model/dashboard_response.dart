import 'dart:convert';

import 'slider_info.dart';
import 'category_info.dart';
import 'product_info.dart';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

class DashboardResponse {
  DashboardResponse({
    required this.isSuccess,
    this.recommImage,
    this.sliders,
    this.categories,
    this.megaProducts,
    this.flashSaleProducts,
    this.products,
    this.Message,
    this.ErrorCode,
    required this.offset,
  });

  DashboardResponse.fromJson(dynamic json) {
    isSuccess = json['IsSuccess'];
    recommImage = json['recomm_image'];
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((v) {
        sliders?.add(SliderInfo.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(CategoryInfo.fromJson(v));
      });
    }
    if (json['mega_products'] != null) {
      megaProducts = [];
      json['mega_products'].forEach((v) {
        megaProducts?.add(ProductInfo.fromJson(v));
      });
    }
    if (json['flash_sale_products'] != null) {
      flashSaleProducts = [];
      json['flash_sale_products'].forEach((v) {
        flashSaleProducts?.add(ProductInfo.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductInfo.fromJson(v));
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
  String? recommImage;
  List<SliderInfo>? sliders;
  List<CategoryInfo>? categories;
  List<ProductInfo>? megaProducts;
  List<ProductInfo>? flashSaleProducts;
  List<ProductInfo>? products;
  int offset = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsSuccess'] = isSuccess;
    map['recomm_image'] = recommImage;
    if (sliders != null) {
      map['sliders'] = sliders?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (megaProducts != null) {
      map['mega_products'] = megaProducts?.map((v) => v.toJson()).toList();
    }
    if (flashSaleProducts != null) {
      map['flash_sale_products'] =
          flashSaleProducts?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    if (Message != null) {
      map['Message'] = Message;
    }
    if (ErrorCode != null) {
      map['ErrorCode'] = ErrorCode;
    }
    return map;
  }
}
