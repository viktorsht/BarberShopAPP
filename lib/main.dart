import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/hours/hours_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/modules/auth/domain/repositories/auth_repository.dart';
import 'src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/modules/auth/presentation/update/bloc/update_costumer_bloc.dart';
import 'src/modules/schedule/domain/repositories/schedule_repository.dart';
import 'src/modules/schedule/presentation/bloc/schedule_bloc.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();

  //await loadPreferences();

  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          BlocProvider<CreateCustomerBloc>(create: (context) => CreateCustomerBloc(Modular.get<AuthRepository>())),
          BlocProvider<UpdateCostumerBloc>(create: (context) => UpdateCostumerBloc(Modular.get<AuthRepository>())),
          BlocProvider<ScheduleBloc>(create: (context) => ScheduleBloc(Modular.get<ScheduleRepositoty>(), Modular.get<AuthRepository>())),
          BlocProvider<HoursBloc>(create: (context) => HoursBloc(Modular.get<ScheduleRepositoty>())),
        ],
        child: ModularApp(
          module: AppModule(), 
          child: const AppWidget(),
        ),
      ),
    )
  );
}