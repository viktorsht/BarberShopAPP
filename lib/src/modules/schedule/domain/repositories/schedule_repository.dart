import 'package:client_barber_shop/src/external/response/response_presentation.dart';
import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/hours_active_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';

import '../entities/barber_entity.dart';
import '../entities/services_entity.dart';

abstract class ScheduleRepositoty{
  Future<ResponsePresentation> createSchedule(ScheduleEntity entity);
  Future<List<ServicesEntity>> fetchServices();
  Future<List<BarberEntity>> fetchBarbers();
  Future<List<HoursActiveEntity>> fetchHoursActive();
  Future<List<HoursActiveEntity>> fetchHoursActiveByDay(int day);
  Future<ScheduleEntity> fetchPrefesSchedule();
  Future<CustomerEntity> fetchPrefesCustomer();
}