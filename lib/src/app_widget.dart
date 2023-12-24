import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'constants/constants.dart';
import 'themes/app_themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static void setAppPreferences(double newFontSize, ThemeMode newThemeData) {
    Constants.fontSizeMin = newFontSize;
    Constants.themeApp = newThemeData;
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Barbearia Cliente',
        routerConfig: Modular.routerConfig,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
    );
  }
}