class BarberEntity {
  int? id;
  String? name;
  String? phone;

  BarberEntity({
    this.id,
    this.name,
    this.phone
  });

  BarberEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
