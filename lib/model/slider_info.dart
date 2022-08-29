class SliderInfo {
  SliderInfo({
      this.id, 
      this.text, 
      this.image,});

  SliderInfo.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    image = json['image'];
  }
  int? id;
  String? text;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['image'] = image;
    return map;
  }

}