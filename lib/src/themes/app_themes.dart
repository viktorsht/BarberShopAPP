import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true).copyWith(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(

        primary: AppColors.primaryColor,
        secondary: AppColors.secundaryColor,
        background: AppColors.background,

        onPrimary: AppColors.primaryColorText,
        onSecondary: AppColors.secundaryColorText,
      )
  );
  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true).copyWith(
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primaryColorDark,
        secondary: AppColors.secundaryColorDark,
        background: AppColors.backgroundDark,

        onPrimary: AppColors.primaryColorTextDark,
        onSecondary: AppColors.secundaryColorTextDark,
      )
  );
}