import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/hours_active_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../external/response/response_presentation.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/barber_entity.dart';
import '../../domain/entities/payment_methods_entity.dart';
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
    on<ConfirmeScheduleEvent> (_getHours);
    on<CreateScheduleEvent> (_post);
  }

  void _get(ScheduleEvent event, Emitter<BlocState> emit) async{
    emit(ScheduleLoadingState());
    try {
      List<BarberEntity> barber = await scheduleRepositoty.fetchBarbers(); 
      List<ServicesEntity> services = await scheduleRepositoty.fetchServices();
      List<PaymentMethodsEntity> pay = await scheduleRepositoty.fetchPaymentMethods();
      List<HoursActiveEntity> hours = await scheduleRepositoty.fetchHoursActive();
      emit(ScheduleSucessState(hours:hours, barber: barber, services: services, pay: pay));
    } 
    on ResponsePresentation catch (e) {
      emit(ScheduleErrorState(error: e));
    }
  }

  void _getHours(ConfirmeScheduleEvent event, Emitter<BlocState> emit) async {
    emit(ScheduleLoadingState());
    try {
      ScheduleEntity entity = await scheduleRepositoty.fetchPrefesSchedule();
      CustomerEntity customerEntity = await scheduleRepositoty.fetchPrefesCustomer();
      ResponsePresentation customer = await authRepository.fetchCustomer(customerEntity.phone.toString());
      if(customer.success == true){
        emit(ConfirmeSucessState(entity: ScheduleEntity(service: entity.service, barber: entity.barber, payment: entity.payment, client: customer.body.id)));
      }
      emit(ScheduleErrorState(error: ResponsePresentation(success: false, message: 'Cliente não existe')));
    } 
    on ResponsePresentation catch (e) {
      emit(ScheduleErrorState(error: e));
    }
  }

  void _post(CreateScheduleEvent event, Emitter<BlocState> emit) async {}

}