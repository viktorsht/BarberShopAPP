part of 'bloc_schedule.dart';

@immutable
sealed class BlocEvent {}

class PostScheduleEvent extends BlocEvent{
  final ScheduleEntity schedule;

  PostScheduleEvent(this.schedule);
}