class HoursActiveEntity {
  int? id;
  String? time;
  bool? status;

  HoursActiveEntity({this.id, this.time, this.status});

  HoursActiveEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}
