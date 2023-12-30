import 'dart:convert';

import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';
import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/name.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/phone.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/hours_active_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';

import '../../../external/http/http_client.dart';
import '../../../external/response/response_presentation.dart';
import '../../../utils/shared.dart';
import '../domain/entities/barber_entity.dart';
import '../domain/entities/payment_methods_entity.dart';
import '../domain/entities/services_entity.dart';
import '../domain/repositories/schedule_repository.dart';

class ScheduleRepositotyImpl implements ScheduleRepositoty{

  final ClientHttp service;

  ScheduleRepositotyImpl(this.service);

  @override
  Future<ResponsePresentation> createSchedule(ScheduleEntity entity) async {
    try {
      await service.post(RoutesApi.schedule, HeadersApi.getHeaders(), entity.toJson());
      return ResponsePresentation(success: true);
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<List<BarberEntity>> fetchBarbers() async {
    try{
      var response = await service.get(RoutesApi.barbers, HeadersApi.getHeaders());
      var jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => BarberEntity.fromJson(e)).toList();
    }
    catch(e){
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<List<PaymentMethodsEntity>> fetchPaymentMethods() async {
    try {
      var response = await service.get(RoutesApi.paymentMethods, HeadersApi.getHeaders());
      var jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => PaymentMethodsEntity.fromJson(e)).toList();
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<List<ServicesEntity>> fetchServices() async {
    try {
      final response = await service.get(RoutesApi.services, HeadersApi.getHeaders());
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => ServicesEntity.fromJson(e)).toList();
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<List<HoursActiveEntity>> fetchHoursActive() async {
    try{
      final response = await service.get(RoutesApi.hours, HeadersApi.getHeaders());
      final jsonList = jsonDecode(response.body) as List;
      final filteredList = jsonList.where((element) => element['status'] == true).toList(); // pega só os true
      return filteredList.map((e) => HoursActiveEntity.fromJson(e)).toList();
    }
    catch(e){
      throw ResponsePresentation(success: false);
    }
  }
  
  @override
  Future<List<HoursActiveEntity>> fetchHoursActiveByDay(int day) async {
    try {
      var url = '${RoutesApi.hoursActive}/$day';
      final response = await service.get(url, HeadersApi.getHeaders());
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => HoursActiveEntity.fromJson(e)).toList();
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<ScheduleEntity> fetchPrefesSchedule() async {
    try {
      String scheduledTime = await SchedulePreferencesHelper.getScheduledTime() ?? '';
      int service = await SchedulePreferencesHelper.getService() ?? 0;
      int pay = await SchedulePreferencesHelper.getPayment() ?? 0;
      int barber = await SchedulePreferencesHelper.getBarber() ?? 0;
      return ScheduleEntity(
        scheduledTime: scheduledTime,
        service: service,
        payment: pay,
        barber: barber,
      );
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<CustomerEntity> fetchPrefesCustomer() async {
    try {
      String name = await SharedPreferencesHelper.getClientName() ?? '';
      String phone = await SharedPreferencesHelper.getClientPhone() ?? '';
      return CustomerEntity(
        name: Name(name),
        phone: Phone(phone),
      );

    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

}