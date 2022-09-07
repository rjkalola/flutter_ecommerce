class CategoryInfo {
  CategoryInfo({
    this.id,
    this.name,
    this.image,
    this.parent_id,
    this.child,
  });

  CategoryInfo.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parent_id = json['parent_id'];
    if (json['child'] != null) {
      child = [];
      json['child'].forEach((v) {
        child?.add(CategoryInfo.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  String? image;
  int? parent_id;
  List<CategoryInfo>? child;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['parent_id'] = parent_id;
    if (child != null) {
      map['child'] = child?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
