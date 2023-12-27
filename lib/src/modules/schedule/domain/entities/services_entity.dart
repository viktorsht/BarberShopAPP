class ServicesEntity {
  int? id;
  String? name;
  int? durationMinutes;
  double? price;

  ServicesEntity({
    this.id, 
    this.name, 
    this.durationMinutes, 
    this.price
  });

  ServicesEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    durationMinutes = json['durationMinutes'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['durationMinutes'] = durationMinutes;
    data['price'] = price;
    return data;
  }
}
