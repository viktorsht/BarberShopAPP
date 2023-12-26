import 'package:client_barber_shop/src/external/http/http_client.dart';
import 'package:client_barber_shop/src/external/http/http_client_impl.dart';
import 'package:client_barber_shop/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'modules/auth/presentation/create/pages/create_costumer_page.dart';


class AppModule extends Module {

  @override
  void binds(Injector i) {
    i.add<ClientHttp>(ClientHttpImpl.new);
    i.addInstance(Client());
  }

  @override
  void routes(r) {
    r.child('/create', child: (context) => const CreateCostumerPage());
    r.child('/', child: (context) => const SplashPage());
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}