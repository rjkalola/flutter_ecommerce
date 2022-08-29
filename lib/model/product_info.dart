class ProductInfo {
  ProductInfo({
      this.liked, 
      this.modal, 
      this.id, 
      this.name, 
      this.description, 
      this.image, 
      this.price, 
      this.review, 
      this.reviewCount, 
      this.weight,});

  ProductInfo.fromJson(dynamic json) {
    liked = json['liked'];
    modal = json['modal'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    review = json['review'];
    reviewCount = json['review_count'];
    weight = json['weight'];
  }
  bool? liked;
  String? modal;
  int? id;
  String? name;
  String? description;
  String? image;
  String? price;
  String? review;
  int? reviewCount;
  String? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liked'] = liked;
    map['modal'] = modal;
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['price'] = price;
    map['review'] = review;
    map['review_count'] = reviewCount;
    map['weight'] = weight;
    return map;
  }

}