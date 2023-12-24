import 'package:client_barber_shop/src/modules/schedule/data/datasources/schedule_datasource.dart';
import 'package:client_barber_shop/src/modules/schedule/data/mapper/schedule_entity_mapper.dart';
import 'package:client_barber_shop/src/modules/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/repositories/schedule_repository.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/usecases/schedule_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class PostScheduleRepositoryMock extends Mock implements ScheduleRepository {}
class PostScheduleDataSourceMock extends Mock implements ScheduleDataSource {}

void main() {
  final datasource = PostScheduleDataSourceMock();
  final repository = ScheduleRepositoryImpl(datasource);
  final usecase = ScheduleUseCaseImpl(repository);

  test(
    'PostScheduleUseCaseImpl should return success response',
    () async {
      // Crie uma instância da entidade ScheduleEntity para simular os dados
      const scheduleEntity = ScheduleEntity(
        id: null,
        barberman: 1,
        customer: 2,
        scheduleHours: '2023-12-31 12:00:00',
        service: 3,
        payMethods: 4,
      );

      final dto = ScheduleEntityMapper.toEntity(scheduleEntity);

      // Simule o comportamento do repositório
      when(datasource.createSchedule(dto)).thenAnswer((_) async => dto);

      // Chame o caso de uso
      var response = await usecase.createSchedule(scheduleEntity);

      // Verifique se a resposta indica sucesso
      expect(response.message, isNull);
      expect(response.success, true);
      // Verifique se a resposta contém o corpo correto
      expect(response.body, isA<ScheduleEntityMapper>());
      // Verifique se a mensagem de erro é nula
    },
  );
}
