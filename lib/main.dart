import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/modules/auth/domain/repositories/auth_repository.dart';
import 'src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();

  //await loadPreferences();

  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          BlocProvider<CreateCustomerBloc>(create: (context) => CreateCustomerBloc(Modular.get<AuthRepository>())),
        ],
        child: ModularApp(
          module: AppModule(), 
          child: const AppWidget(),
        ),
      ),
    )
  );
}

/*Future<void> loadPreferences() async {
  final appPreferences = AppPreferences();
  double fontSize = await appPreferences.getFontSize();
  ThemeMode themeMode = await appPreferences.getThemeMode();
  AppWidget.setAppPreferences(fontSize, themeMode);
}*/