class PaymentMethodsEntity {
  int? id;
  String? name;
  bool? status;

  PaymentMethodsEntity({
    this.id, 
    this.name, 
    this.status
  });

  PaymentMethodsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
