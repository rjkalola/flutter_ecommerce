class OfferInfo {
  OfferInfo({
    this.id,
    this.product_id,
    this.category_id,
    this.image,
  });

  OfferInfo.fromJson(dynamic json) {
    id = json['id'];
    product_id = json['product_id'];
    category_id = json['category_id'];
    image = json['image'];
  }

  int? id;
  int? product_id;
  int? category_id;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = product_id;
    map['category_id'] = category_id;
    map['image'] = image;
    return map;
  }
}
