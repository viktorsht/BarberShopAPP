import 'dart:convert';

import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';
import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';

import '../../../external/http/http_client.dart';
import '../../../external/response/response_presentation.dart';
import '../domain/entities/data_client.dart';
import '../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final ClientHttp service;

  AuthRepositoryImpl(this.service);

  @override
  Future<ResponsePresentation> createCustomer(CustomerEntity entity) async {
    try{
      await service.post(RoutesApi.clients, HeadersApi.getHeaders(), entity.toJson());
      return ResponsePresentation(success: true);
    }
    catch(e){
      throw(ResponsePresentation(success: false, message: "Erro na requisição: ${e.toString()}")); 
    }
  }
  
  @override
  Future<ResponsePresentation> updateCustomer(int userId, CustomerEntity entity) async{
    try{
      var url = '${RoutesApi.clients}/$userId';
      await service.update(url, HeadersApi.getHeaders(), entity.toJson());
      return ResponsePresentation(success: true);
    }
    catch(e){
      throw ResponsePresentation(success: false);
    }
  }
  
  @override
  Future<DataClient> fetchCustomer(String phone) async {
    try{
      var url = '${RoutesApi.clients}/$phone';
      var response = await service.get(url, HeadersApi.getHeaders());
      final json = jsonDecode(response.body);
      return DataClient.fromJson(json);//CustomerEntityResponsePresentation(success: true, body: response);
    }
    catch(e){
      throw ResponsePresentation(success: false);
    }
  }

}