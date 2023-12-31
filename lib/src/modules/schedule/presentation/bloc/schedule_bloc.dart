import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../external/response/response_presentation.dart';
import '../../../auth/domain/entities/data_client.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/barber_entity.dart';
import '../../domain/entities/schedule_entity.dart';
import '../../domain/entities/services_entity.dart';
import '../../domain/repositories/schedule_repository.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class ScheduleBloc extends Bloc<BlocEvent, BlocState>{

  final ScheduleRepositoty scheduleRepositoty;
  final AuthRepository authRepository;

  ScheduleBloc(this.scheduleRepositoty, this.authRepository) : super(ScheduleInitial()){
    on<ScheduleEvent> (_get);
    on<ConfirmeScheduleEvent> (_getSchedule);
    on<CreateScheduleEvent> (_post);
  }

  void _get(ScheduleEvent event, Emitter<BlocState> emit) async{
    emit(ScheduleLoadingState());
    try {
      List<BarberEntity> barber = await scheduleRepositoty.fetchBarbers(); 
      List<ServicesEntity> services = await scheduleRepositoty.fetchServices();
      emit(ScheduleSucessState( barber: barber, services: services));
    } 
    on Exception catch (e) {
      emit(ScheduleErrorState(error: e.toString()));
    }
  }

  void _getSchedule(ConfirmeScheduleEvent event, Emitter<BlocState> emit) async {
    emit(ConfirmeLoadingState());
    try {
      ScheduleEntity entity = await scheduleRepositoty.fetchPrefesSchedule();
      CustomerEntity customerEntity = await scheduleRepositoty.fetchPrefesCustomer();
      DataClient customer = await authRepository.fetchCustomer(customerEntity.phone.toString());
        emit(ConfirmeSucessState(
          entity: ScheduleEntity(
            scheduledTime: entity.scheduledTime,
            service: entity.service, 
            barber: entity.barber, 
            client: customer.id
          )
        )
      );
    } 
    on ResponsePresentation catch (e) {
      emit(ConfirmeErrorState(error: e));
    }
  }

  void _post(CreateScheduleEvent event, Emitter<BlocState> emit) async {
    emit(CreateScheduleLoadingState());
    try {
      await scheduleRepositoty.createSchedule(event.entity);
      emit(CreateScheduleState());
    } catch (e) {
      emit(CreateScheduleErrorState(error: e.toString()));
    }
  }

}