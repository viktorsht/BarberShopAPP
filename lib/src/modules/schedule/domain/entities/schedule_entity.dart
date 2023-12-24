class ScheduleEntity {
  int? id;
  String? scheduledDay;
  int? service;
  int? paymentMethod;
  int? client;
  int? barber;
  String? createdAt;

  ScheduleEntity(
      {this.id,
      this.scheduledDay,
      this.service,
      this.paymentMethod,
      this.client,
      this.barber,
      this.createdAt});

  ScheduleEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduledDay = json['scheduledDay'];
    service = json['service'];
    paymentMethod = json['paymentMethod'];
    client = json['client'];
    barber = json['barber'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['scheduledDay'] = scheduledDay;
    data['service'] = service;
    data['paymentMethod'] = paymentMethod;
    data['client'] = client;
    data['barber'] = barber;
    data['createdAt'] = createdAt;
    return data;
  }
}
