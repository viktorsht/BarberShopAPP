import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/repositories/add_schedule_repository.dart';

import '../../../../external/response/response_presentation.dart';

abstract class PostScheduleUseCase{
  Future<ResponsePresentation> call(ScheduleEntity scheduleEntity);
}

class PostScheduleUseCaseImpl implements PostScheduleUseCase{

  final PostScheduleRepository postScheduleRepository;

  PostScheduleUseCaseImpl(this.postScheduleRepository);

  @override
  Future<ResponsePresentation> call(ScheduleEntity scheduleEntity) async {
    try{
      var response = await postScheduleRepository(scheduleEntity);
      return ResponsePresentation(success: true, body: response);
    }
    catch(e){
      return ResponsePresentation(success: false, message: e.toString());
    }
  }
}