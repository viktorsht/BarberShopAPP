import 'package:client_barber_shop/src/external/http/http_client_impl.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import '../../external/http/http_client.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/create/bloc/create_costumer_bloc.dart';
import 'presentation/create/pages/create_costumer_page.dart';
import 'repositories/auth_repositoty_impl.dart';

class AuthModule extends Module {

  @override
  void exportedBinds(Injector i) {
    i.add<AuthRepository>(AuthRepositoryImpl.new);
    i.addSingleton<ClientHttp>(ClientHttpImpl.new);
    //i.add<ClientHttp>(ClientHttpImpl.new);
    i.addInstance(Client());
    i.addSingleton(CreateCustomerBloc.new);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.createUser, child: (context) => CreateCostumerPage(controller: Modular.get()));
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}