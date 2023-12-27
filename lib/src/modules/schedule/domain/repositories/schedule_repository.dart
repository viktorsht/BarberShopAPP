import 'package:client_barber_shop/src/external/response/response_presentation.dart';

import '../entities/barber_entity.dart';
import '../entities/payment_methods_entity.dart';
import '../entities/services_entity.dart';

abstract class ScheduleRepositoty{
  Future<ResponsePresentation> createSchedule();
  Future<List<ServicesEntity>> fetchServices();
  Future<List<PaymentMethodsEntity>> fetchPaymentMethods();
  Future<List<BarberEntity>> fetchBarbers();
}