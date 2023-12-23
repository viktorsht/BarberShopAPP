import 'dart:convert';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';

class ScheduleEntityMapper extends ScheduleEntity{

  const ScheduleEntityMapper({
    required super.id,
    required super.barberman,
    required super.customer,
    required super.scheduleHours,
    required super.payMethods,
    required super.service,
  });
  
  static fromMap(Map<String, dynamic> map) {
    return ScheduleEntityMapper(
      id: map['id'],
      scheduleHours: map['scheduledDay'],
      service: map['service'],
      payMethods: map['paymentMethod'],
      customer: map['client'],
      barberman: map['barber'],
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'id' : id,
      'scheduledDay' : scheduleHours,
      'service' : service,
      'paymentMethod' : payMethods,
      'barber' : barberman,
      'client' : customer,
    };
  }

  String toJson() => json.encode(toMap());

  static ScheduleEntityMapper fromJson(String source) => fromMap(json.decode(source));
}