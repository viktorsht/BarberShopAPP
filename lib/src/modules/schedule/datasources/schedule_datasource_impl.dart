import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';

import '../../../external/http/http_client.dart';
import '../data/datasources/schedule_datasource.dart';
import '../domain/entities/schedule_entity.dart';

class ScheduleDataSourceImpl implements ScheduleDataSource{
  
  final HttpService client;
  ScheduleDataSourceImpl(this.client);
  
  @override
  Future<Map<String, dynamic>> createSchedule(ScheduleEntity scheduleEntity) async {
    try{
      var response = await client.post(RoutesApi.schedule, HeadersApi.getHeaders(), scheduleEntity.toJson());
      return response;
    }
    on Exception catch (e){
      throw Exception(e.toString());
    }
  }

}