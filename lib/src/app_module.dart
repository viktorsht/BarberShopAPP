import 'package:client_barber_shop/src/external/http/http_client.dart';
import 'package:client_barber_shop/src/external/http/http_client_impl.dart';
import 'package:client_barber_shop/src/modules/auth/auth_module.dart';
import 'package:client_barber_shop/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'modules/home/home_module.dart';
import 'routes/app_routes.dart';

class AppModule extends Module {

  @override
  void exportedBinds(Injector i) {
    i.add<ClientHttp>(ClientHttpImpl.new);
    i.addInstance(Client());
  }

  @override
  void routes(r) {
    r.child(AppRoutes.root, child: (context) => const SplashPage());

    r.module(AppRoutes.authModule, module: AuthModule());
    r.module(AppRoutes.homeModule, module: HomeModule());
  }

  @override
  List<Module> get imports => [
    AuthModule(),
  ];
}