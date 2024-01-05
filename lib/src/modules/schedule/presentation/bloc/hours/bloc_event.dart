part of 'hours_bloc.dart';

@immutable
sealed class BlocEvent {}

class HoursScheduleEvent extends BlocEvent{
  final int day;

  HoursScheduleEvent(this.day);
}