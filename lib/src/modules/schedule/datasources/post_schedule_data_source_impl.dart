import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';
import 'package:client_barber_shop/src/modules/schedule/data/mapper/schedule_entity_mapper.dart';

import '../../../external/http/http_client.dart';
import '../data/datasources/post_schedule_datasource.dart';

class PostScheduleDataSourceImpl implements PostScheduleDataSource{
  
  final HttpService client;
  PostScheduleDataSourceImpl(this.client);
  
  @override
  Future<Map<String, dynamic>> call(ScheduleEntityMapper scheduleEntityMapper) async {
    var response = await client.post(RoutesApi.schedule, HeadersApi.getHeaders(), scheduleEntityMapper.toMap());
    return response;
  }

}