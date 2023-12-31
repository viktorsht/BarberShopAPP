class ScheduleEntity {
  String? scheduledTime;
  int? service;
  int? client;
  int? barber;

  ScheduleEntity({this.scheduledTime,
      this.service,
      this.client,
      this.barber});

  ScheduleEntity.fromJson(Map<String, dynamic> json) {
    scheduledTime = json['scheduledTime'];
    service = json['service'];
    client = json['client'];
    barber = json['barber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduledTime'] = scheduledTime;
    data['service'] = service;
    data['client'] = client;
    data['barber'] = barber;
    return data;
  }
}
