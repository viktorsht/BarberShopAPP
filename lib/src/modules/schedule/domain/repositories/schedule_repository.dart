import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';


abstract class ScheduleRepository{
  Future<ScheduleEntity> createSchedule(ScheduleEntity scheduleEntity);
  Future<ScheduleEntity> getAllSchedule(ScheduleEntity scheduleEntity);
  Future<ScheduleEntity> getNextSchedule(ScheduleEntity scheduleEntity); // buscar o agendamento mais próximo da data de hoje
  Future<ScheduleEntity> updateSchedule(ScheduleEntity scheduleEntity);
  Future<ScheduleEntity> deleteSchedule(ScheduleEntity scheduleEntity);
}