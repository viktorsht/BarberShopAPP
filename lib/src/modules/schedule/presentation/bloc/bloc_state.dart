part of 'schedule_bloc.dart';


@immutable
sealed class BlocState {}

final class ScheduleInitial extends BlocState {}

class ScheduleErrorState extends BlocState {
  final ResponsePresentation error;

  ScheduleErrorState({required this.error});
}

class ScheduleSucessState extends BlocState {
  final List<BarberEntity> barber;
  final List<ServicesEntity> services;
  final List<PaymentMethodsEntity> pay;
  final List<HoursActiveEntity> hours;

  ScheduleSucessState({required this.hours, required this.barber, required this.services, required this.pay});

}

class ConfirmeSucessState extends BlocState{
  final ScheduleEntity entity;

  ConfirmeSucessState({required this.entity});

}

class ScheduleLoadingState extends BlocState {}
class CreateScheduleState extends BlocState {}

