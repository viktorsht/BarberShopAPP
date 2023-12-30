import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/scheduled_time.dart';
import '../../domain/entities/schedule_entity.dart';

// State
abstract class ScheduleState {}

class ScheduleInitialState extends ScheduleState {}

class ScheduleSavedState extends ScheduleState {
  final ScheduleEntity scheduleEntity;

  ScheduleSavedState(this.scheduleEntity);
}

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleInitialState());

  void saveSchedule({
    required String selectDate,
    required int selectedServicesId,
    required int selectedBarberId,
    required int selectedPayId,
  }) {
    final entity = ScheduleEntity(
      scheduledTime: selectDate,
      service: selectedServicesId,
      barber: selectedBarberId,
      payment: selectedPayId,
    );

    emit(ScheduleSavedState(entity));
  }
}
