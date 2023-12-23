import '../../domain/entities/schedule_entity.dart';
import '../../domain/repositories/add_schedule_repository.dart';
import '../datasources/post_schedule_datasource.dart';
import '../mapper/schedule_entity_mapper.dart';

class PostScheduleRepositoryImpl implements PostScheduleRepository{
  final PostScheduleDataSource postScheduleDataSource;

  PostScheduleRepositoryImpl(this.postScheduleDataSource);

  @override
  Future<ScheduleEntity> call(ScheduleEntity scheduleEntity) async {
    try{
      var res = await postScheduleDataSource(ScheduleEntityMapper.toEntity(scheduleEntity));
      return ScheduleEntityMapper.fromMap(res);
    }
    catch(e){
      rethrow;
    }
  }

}