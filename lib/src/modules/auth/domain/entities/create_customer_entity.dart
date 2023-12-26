import '../valueobject/name.dart';
import '../valueobject/phone.dart';

class CreateCustomerEntity {
  Name? name;
  Phone? phone;

  CreateCustomerEntity({this.name, this.phone});

  CreateCustomerEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name.toString();
    data['phone'] = phone.toString();
    return data;
  }

  factory CreateCustomerEntity.empty(){
    return CreateCustomerEntity(
      name: Name(''), 
      phone: Phone(''),
    );
  }

}
