import '../mapper/schedule_entity_mapper.dart';

abstract class PostScheduleDataSource {
  Future<Map<String, dynamic>> call(ScheduleEntityMapper scheduleEntityMapper);
}