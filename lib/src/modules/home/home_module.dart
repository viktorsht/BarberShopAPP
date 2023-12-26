import 'package:client_barber_shop/src/modules/home/presentation/home_page.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module{
  @override
  void binds(Injector i) {
  }

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.root, child: (context) => const HomePage());
  }
}