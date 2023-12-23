import '../../domain/entities/schedule_entity.dart';

abstract class PostScheduleDataSource {
  Future<Map<String, dynamic>> call(ScheduleEntity scheduleEntity);
}