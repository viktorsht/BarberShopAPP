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
      id: map['id'] ?? 0,
      scheduleHours: map['scheduledDay'],
      service: map['service'],
      payMethods: map['paymentMethod'],
      customer: map['client'],
      barberman: map['barber'],
    );
  }

  static toEntity(ScheduleEntity entity) {
    return ScheduleEntityMapper(
      id: entity.id,
      scheduleHours: entity.scheduleHours,
      service: entity.service,
      payMethods: entity.payMethods,
      customer: entity.customer,
      barberman: entity.barberman,
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