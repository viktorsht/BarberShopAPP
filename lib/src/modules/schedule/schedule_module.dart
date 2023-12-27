import 'package:client_barber_shop/src/modules/schedule/domain/repositories/schedule_repository.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/pages/schedule_page.dart';
import 'package:client_barber_shop/src/modules/schedule/repositories/schedule_repository_impl.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import '../../external/http/http_client.dart';
import '../../external/http/http_client_impl.dart';
import '../auth/auth_module.dart';

class ScheduleModule extends Module{

  @override
  void binds(Injector i) {
    i.add<ScheduleRepositoty>(ScheduleRepositotyImpl.new);
    i.addSingleton(ScheduleBloc.new);
    i.add<ClientHttp>(ClientHttpImpl.new);
    i.addInstance(Client());
  }

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.root, child: (context) => SchedulePage(controller: Modular.get(),));
  }

  @override
  List<Module> get imports => [
    AuthModule(),
  ];
}