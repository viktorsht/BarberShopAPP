part of 'hours_bloc.dart';

@immutable
sealed class HoursBlocState {}

final class HoursInitial extends HoursBlocState{}

class HoursSucessStatee extends HoursBlocState{
  final List<HoursActiveEntity> hours;

  HoursSucessStatee({required this.hours});
}

class HoursErrorState extends HoursBlocState {
  final String error;

  HoursErrorState({required this.error});
}

final class HoursLoadingState extends HoursBlocState {}