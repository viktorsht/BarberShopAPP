class HoursActiveEntity {
  int? id;
  int? day;
  String? time;
  bool? status;

  HoursActiveEntity({this.id, this.day, this.time, this.status});

  HoursActiveEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day =json['day'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}
