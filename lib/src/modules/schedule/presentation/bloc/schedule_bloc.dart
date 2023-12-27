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
    on<CreateScheduleEvent> (_post);
  }

  void _get(ScheduleEvent event, Emitter<BlocState> emit) async{
    emit(ScheduleLoadingState());
    try {
      List<BarberEntity> barber = await scheduleRepositoty.fetchBarbers(); 
      List<ServicesEntity> services = await scheduleRepositoty.fetchServices();
      List<PaymentMethodsEntity> pay = await scheduleRepositoty.fetchPaymentMethods();
      //ResponsePresentation customer = await authRepository.fetchCustomer(event.phone);
      emit(ScheduleSucessState(barber: barber, services: services, pay: pay));
    } 
    on ResponsePresentation catch (e) {
      emit(ScheduleErrorState(error: e));
    }
  }

  void _post(CreateScheduleEvent event, Emitter<BlocState> emit) async {}

}