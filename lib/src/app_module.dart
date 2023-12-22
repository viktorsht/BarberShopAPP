import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  void binds(Injector i) {
    //i.add(BlocBooks.new);
    //i.add(BookRepository.new);
    //i.add<IClient>(HttpService.new);
    //i.addInstance(Client());
  }

  @override
  void routes(r) {
    //r.child(RoutesApp.root, child: (context) => const SplashPage());
    //r.module(RoutesApp.showChapters, module: ChaptersModule());
  }
}