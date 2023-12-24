import 'package:client_barber_shop/src/external/http/http_client.dart';
import 'package:client_barber_shop/src/modules/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:client_barber_shop/src/modules/schedule/datasources/schedule_datasource_impl.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/usecases/schedule_usecases.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/bloc_schedule.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'modules/schedule/presentation/page/teste.dart';

class AppModule extends Module {

  @override
  void binds(Injector i) {
    i.add(BlocSchedule.new);
    i.add(ScheduleUseCaseImpl.new);
    i.add(ScheduleRepositoryImpl.new);
    i.add(ScheduleDataSourceImpl.new);
    i.add<ClientHttp>(HttpService.new);
    i.addInstance(Client());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const MyWidget());
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}