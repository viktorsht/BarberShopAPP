class ScheduleEntity {
  String? scheduledTime;
  int? service;
  int? payment;
  int? client;
  int? barber;

  ScheduleEntity({this.scheduledTime,
      this.service,
      this.payment,
      this.client,
      this.barber});

  ScheduleEntity.fromJson(Map<String, dynamic> json) {
    scheduledTime = json['scheduledTime'];
    service = json['service'];
    payment = json['payment'];
    client = json['client'];
    barber = json['barber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduledTime'] = scheduledTime;
    data['service'] = service;
    data['payment'] = payment;
    data['client'] = client;
    data['barber'] = barber;
    return data;
  }
}
