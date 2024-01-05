import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/hours_active_entity.dart';
import '../../../domain/repositories/schedule_repository.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class HoursBloc extends Bloc<BlocEvent, HoursBlocState>{

  final ScheduleRepositoty scheduleRepositoty;

  HoursBloc(this.scheduleRepositoty) : super(HoursInitial()){
    on<HoursScheduleEvent> (_getHoursActive);
  }

  void _getHoursActive(HoursScheduleEvent event, Emitter<HoursBlocState> emit) async {
    emit(HoursLoadingState());
    try {
      List<HoursActiveEntity> hours = await scheduleRepositoty.fetchHoursActiveByDay(event.day);
      emit(HoursSucessStatee(hours: hours));
    }
    on Exception catch (e) {
      emit(HoursErrorState(error: e.toString()));
    }
  }
}