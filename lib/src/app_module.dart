import 'package:client_barber_shop/src/external/http/http_client.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'modules/auth/presentation/create/create_costumer_page.dart';


class AppModule extends Module {

  @override
  void binds(Injector i) {
    i.add<ClientHttp>(HttpService.new);
    i.addInstance(Client());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const CreateCostumerPage());
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}