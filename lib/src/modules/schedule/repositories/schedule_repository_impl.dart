import 'dart:convert';

import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';

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
    // TODO: implement createSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<BarberEntity>> fetchBarbers() async {
    try{
      var response = await service.get(RoutesApi.barber, HeadersApi.getHeaders());
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
      var response = await service.get(RoutesApi.payMethods, HeadersApi.getHeaders());
      var jsonList = jsonDecode(response.body);
      return jsonList.map((e) => PaymentMethodsEntity.fromJson(e)).toList();
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

  @override
  Future<List<ServicesEntity>> fetchServices() async {
    try {
      var response = await service.get(RoutesApi.services, HeadersApi.getHeaders());
      var jsonList = jsonDecode(response.body);
      return jsonList.map((e) => ServicesEntity.fromJson(e)).toList();
    } catch (e) {
      throw ResponsePresentation(success: false);
    }
  }

}