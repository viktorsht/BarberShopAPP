part of 'schedule_bloc.dart';

@immutable
sealed class BlocEvent {}

class ScheduleEvent extends BlocEvent{
  final String phone;

  ScheduleEvent(this.phone);
}

class CreateScheduleEvent extends BlocEvent{
  final ScheduleEntity entity;

  CreateScheduleEvent(this.entity);
}