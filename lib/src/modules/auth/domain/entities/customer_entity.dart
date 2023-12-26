import '../valueobject/name.dart';
import '../valueobject/phone.dart';

class CustomerEntity {
  Name? name;
  Phone? phone;

  CustomerEntity({this.name, this.phone});

  CustomerEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name.toString();
    data['phone'] = phone.toString();
    return data;
  }

  factory CustomerEntity.empty(){
    return CustomerEntity(
      name: Name(''), 
      phone: Phone(''),
    );
  }

}
