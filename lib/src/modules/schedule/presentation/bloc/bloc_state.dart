part of 'schedule_bloc.dart';


@immutable
sealed class BlocState {}

//geral
final class ScheduleInitial extends BlocState {}
final class ScheduleLoadingState extends BlocState {}

class ScheduleErrorState extends BlocState {
  final String error;

  ScheduleErrorState({required this.error});
}

class ScheduleSucessState extends BlocState {
  final List<BarberEntity> barber;
  final List<ServicesEntity> services;

  ScheduleSucessState({required this.barber, required this.services});

}

// confirme
class ConfirmeSucessState extends BlocState{
  final ScheduleEntity entity;

  ConfirmeSucessState({required this.entity});
}

final class ConfirmeLoadingState extends BlocState {}

class ConfirmeErrorState extends BlocState {
  final ResponsePresentation error;

  ConfirmeErrorState({required this.error});
}

// create
class CreateScheduleState extends BlocState {}

final class CreateScheduleLoadingState extends BlocState {}

class CreateScheduleErrorState extends BlocState {
  final String error;

  CreateScheduleErrorState({required this.error});
}

