import '../../domain/entities/schedule_entity.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_datasource.dart';

class ScheduleRepositoryImpl implements ScheduleRepository{
  final ScheduleDataSource scheduleDataSource;

  ScheduleRepositoryImpl(this.scheduleDataSource);

  @override
  Future<ScheduleEntity> createSchedule(ScheduleEntity scheduleEntity) async {
    try{
      var res = await scheduleDataSource.createSchedule(scheduleEntity);
      return ScheduleEntity.fromJson(res);
    }
    catch(e){
      rethrow;
    }
  }
  
  @override
  Future<ScheduleEntity> deleteSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement deleteSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ScheduleEntity> getAllSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement getAllSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ScheduleEntity> getNextSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement getNextSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ScheduleEntity> updateSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement updateSchedule
    throw UnimplementedError();
  }

}