import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants/app_images.dart';
import '../../../routes/app_routes.dart';
import 'widgets/menu_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    // carregar proxímo agendamento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: Constants.nameApp),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppImages.logo, 
                width: 500, 
                height: 150,
              )
            ),
            Center(
              child: Container(
                width: 300, 
                height: 150, 
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: const Text('futuro card de agenda ou anuncio'),
              ),
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8.0, 
                mainAxisSpacing: 8.0,
                children: [
                  MenuItemWidget(
                    message: 'Agendar', 
                    onPressed: () => Modular.to.pushNamed("${AppRoutes.scheduleModule}${AppRoutes.root}"),
                  ),
                  MenuItemWidget(message: 'Minha Agenda', onPressed: () {}),
                  //MenuItemWidget(message: 'Meu Perfil', onPressed: () {}),
                  //MenuItemWidget(message: 'Sobre Nós', onPressed: () {}),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}