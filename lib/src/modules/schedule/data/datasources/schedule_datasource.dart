import '../../domain/entities/schedule_entity.dart';

abstract class ScheduleDataSource {
  Future<Map<String, dynamic>> createSchedule(ScheduleEntity scheduleEntity);
  
}