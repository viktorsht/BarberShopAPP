import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed; // Nova função

  const AppBarWidget({
    Key? key,
    required this.title,
    this.onBackPressed, // Adicione a nova função
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500
        ),
      ),
      backgroundColor: AppColors.secundaryColor,
      centerTitle: true,
      leading: onBackPressed != null
      ? IconButton(
          onPressed: onBackPressed, // Chame a função de navegação
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        )
      : null,
      elevation: 1,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}