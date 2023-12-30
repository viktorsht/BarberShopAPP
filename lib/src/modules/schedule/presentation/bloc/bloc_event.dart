part of 'schedule_bloc.dart';

@immutable
sealed class BlocEvent {}

class ScheduleEvent extends BlocEvent{

}

class CreateScheduleEvent extends BlocEvent{
  final ScheduleEntity entity;

  CreateScheduleEvent(this.entity);
}

class HoursActiveEvent extends BlocEvent{
  final int day;

  HoursActiveEvent(this.day);
}