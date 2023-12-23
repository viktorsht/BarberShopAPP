import 'package:client_barber_shop/src/modules/schedule/data/mapper/schedule_entity_mapper.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/repositories/add_schedule_repository.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/usecases/post_schedule_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
class PostScheduleRepositoryMock extends Mock implements PostScheduleRepository{}
void main() {
  final repository = PostScheduleRepositoryMock();
  final usecase = PostScheduleUseCaseImpl(repository);
  const scheduleEntityMapper = ScheduleEntityMapper(service: 2,barberman: 1,scheduleHours: '22-12-2023 16:00:00', customer: 1, payMethods: 1, id: 0);

  test(
    'testando use case post de agendamento', () async {
      var response = await usecase(scheduleEntityMapper);

      expect(response.body, isA<ScheduleEntity>());
    });
} 