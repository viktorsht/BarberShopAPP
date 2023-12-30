import 'dart:convert';

import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/hours_active_entity.dart';

import '../../../external/http/http_client.dart';
import '../../../external/response/response_presentation.dart';
import '../domain/entities/barber_entity.dart';
import '../domain/entities/payment_methods_entity.dart';
import '../domain/entities/services_entity.dart';
import '../domain/repositories/schedule_repository.dart';

class ScheduleRepositotyImpl implements ScheduleRepositoty{

  final ClientHttp service;

  ScheduleRepositotyImpl(this.service);

  @override
  Future<ResponsePresentation> createSchedule() async {
    throw UnimplementedError(); // ainda falta implementar
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

}