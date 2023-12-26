import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Modular.to.navigate('${AppRoutes.authModule}${AppRoutes.createUser}'); // vai ser home
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Text(AppRoutes.authModule)),
    );
  }
}