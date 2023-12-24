part of 'bloc_schedule.dart';

@immutable
sealed class BlocState {}

final class ScheduleInitial extends BlocState {}

class ScheduleErrorState extends BlocState {
  final String message;

  ScheduleErrorState({required this.message});
}

class ScheduleSucessState extends BlocState {
  final ResponsePresentation data;

  ScheduleSucessState({required this.data});
}

class ScheduleLoadingState extends BlocState {
  ScheduleLoadingState();
}
