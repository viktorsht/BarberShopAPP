import '../valueobject/phone.dart';

class CreateCustomerEntity {
  String? name;
  Phone? phone;

  CreateCustomerEntity({this.name, this.phone});

  CreateCustomerEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
