import 'package:client_barber_shop/src/modules/schedule/datasources/schedule_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:client_barber_shop/src/modules/schedule/data/mapper/schedule_entity_mapper.dart';
import 'package:client_barber_shop/src/external/http/http_client.dart';
import 'package:client_barber_shop/src/external/api/headers.dart';
import 'package:client_barber_shop/src/external/api/routes.dart';

// Crie uma classe mock para HttpService
class MockHttpService extends Mock implements HttpService {}

void main() {
  group('PostScheduleDataSourceImpl', () {
    late ScheduleDataSourceImpl dataSource;
    late MockHttpService mockHttpService;

    setUp(() {
      mockHttpService = MockHttpService();
      dataSource = ScheduleDataSourceImpl(mockHttpService);

    });

    test('should make a POST request and return the response', () async {
      // Arrange
      const scheduleEntityMapper = ScheduleEntityMapper(service: 2,barberman: 1,scheduleHours: '22-12-2023 16:00:00', customer: 1, payMethods: 1, id: 0); // Você precisa ajustar isso conforme sua implementação real

      // Defina o comportamento esperado do mockHttpService.post
      //when(dataSource(scheduleEntityMapper)).thenAnswer((_) async => {'key': 'value'}); // Simulação de uma resposta bem-sucedida

      // Act
      final result = await dataSource.createSchedule(scheduleEntityMapper);

      // Assert
      expect(result, {'key': 'value'});
      // Verifique se o método mockHttpService.post foi chamado com os argumentos corretos
      verify(mockHttpService.post(
        RoutesApi.schedule,
        HeadersApi.getHeaders(),
        scheduleEntityMapper.toJson(),
      )).called(1);
    });
  });
}
