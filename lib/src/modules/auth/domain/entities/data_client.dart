class DataClient {
  int? id;
  String? name;
  String? phone;
  String? createdAt;
  String? updateAt;

  DataClient({this.id, this.name, this.phone, this.createdAt, this.updateAt});

  DataClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updateAt'] = updateAt;
    return data;
  }
}
