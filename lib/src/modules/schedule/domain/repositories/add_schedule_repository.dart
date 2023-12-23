import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';

abstract class PostScheduleRepository{
  Future<ScheduleEntity> call(ScheduleEntity scheduleEntity);
}