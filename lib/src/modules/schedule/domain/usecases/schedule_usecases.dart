import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/repositories/schedule_repository.dart';

import '../../../../external/response/response_presentation.dart';

abstract class ScheduleUseCase{
  Future<ResponsePresentation> createSchedule(ScheduleEntity scheduleEntity);
  Future<ResponsePresentation> getAllSchedule(ScheduleEntity scheduleEntity);
  Future<ResponsePresentation> getNextSchedule(ScheduleEntity scheduleEntity); // buscar o agendamento mais próximo da data de hoje
  Future<ResponsePresentation> updateSchedule(ScheduleEntity scheduleEntity);
  Future<ResponsePresentation> deleteSchedule(ScheduleEntity scheduleEntity);
}

class ScheduleUseCaseImpl implements ScheduleUseCase{

  final ScheduleRepository scheduleRepository;

  ScheduleUseCaseImpl(this.scheduleRepository);

  @override
  Future<ResponsePresentation> createSchedule(ScheduleEntity scheduleEntity) async {
    try{
      var response = await scheduleRepository.createSchedule(scheduleEntity);
      return ResponsePresentation(success: true, body: response);
    }
    catch(e){
      return ResponsePresentation(success: false, message: e.toString());
    }
  }
  
  @override
  Future<ResponsePresentation> deleteSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement deleteSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ResponsePresentation> getAllSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement getAllSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ResponsePresentation> getNextSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement getNextSchedule
    throw UnimplementedError();
  }
  
  @override
  Future<ResponsePresentation> updateSchedule(ScheduleEntity scheduleEntity) {
    // TODO: implement updateSchedule
    throw UnimplementedError();
  }
}