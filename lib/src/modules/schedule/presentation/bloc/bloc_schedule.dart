import 'package:bloc/bloc.dart';
import 'package:client_barber_shop/src/external/response/response_presentation.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/usecases/schedule_usecases.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/schedule_entity.dart';


part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocSchedule extends Bloc<BlocEvent, BlocState>{
  final ScheduleUseCase scheduleUseCase;

  BlocSchedule(this.scheduleUseCase) : super(ScheduleInitial()){
    on<PostScheduleEvent> (_post);
  }

  void _post(PostScheduleEvent event, Emitter<BlocState> emit) async {
    emit(ScheduleLoadingState());
    try{
      final response = await scheduleUseCase.createSchedule(event.schedule);
      emit(ScheduleSucessState(data: response.body));
    }
    catch(e){
      emit(ScheduleErrorState(message: e.toString()));
    }
  }

}