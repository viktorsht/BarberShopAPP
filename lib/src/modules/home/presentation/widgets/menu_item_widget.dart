import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;
  const MenuItemWidget({super.key, required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
            child: Text(message, style: const TextStyle(fontSize: 20),)
          ),
        ),
      )
    );
  }
}