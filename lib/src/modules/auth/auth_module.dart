import 'package:client_barber_shop/src/external/http/http_client_impl.dart';
import 'package:client_barber_shop/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    i.addSingleton(CreateCustomerBloc.new);
  }

  @override
  void routes(r) {
    r.child('/create', child: (context) => const CreateCostumerPage());
    r.child('/', child: (context) => const SplashPage());
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}