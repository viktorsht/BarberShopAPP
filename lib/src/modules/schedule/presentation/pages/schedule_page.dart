import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/constants/constants.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/payment_methods_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/services_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../../../../common_widgets/button_widget.dart';
import '../../../../utils/scheduled_time.dart';
import '../../domain/entities/hours_active_entity.dart';
import '../bloc/schedule_cubit.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleBloc controller;

  const SchedulePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  
  final cubit = ScheduleCubit();

  String? selectedBarber;
  int? selectedBarberId;
  
  String? selectedServices;
  int? selectedServicesId;

  String? selectedPay;
  int? selectedPayId;
  
  String? selectedHour;
  int? selectedHourId;
  
  DateTime selectDate = DateTime.now();

  //List<BarberEntity> itemsBarbers = [];
  //List<ServicesEntity> itemsServices = [];
  //List<HoursActiveEntity> itemsHours = [];

  @override
  void initState() {
    super.initState();
    widget.controller.add(ScheduleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Agendar'),
      body: BlocBuilder<ScheduleBloc, BlocState>(
        bloc: widget.controller,
        builder: (context, state) {
          if (state is ScheduleErrorState) {
            return Center(child: Text(state.error.message.toString()));
          }
          if (state is ScheduleLoadingState) {
            return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor));
          }
          if (state is ScheduleSucessState) {
            
            final itemsBarbers = state.barber;
            final itemsServices = state.services;
            final itemsHours = state.hours;
            final itemsPay = state.pay;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Barbeiro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedBarber,
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (value) {
                      setState(() {
                        final select = itemsBarbers.firstWhere((element) => element.name == value);
                        selectedBarber = select.name;
                        selectedBarberId = select.id;
                      });
                    },
                    items: itemsBarbers.map((BarberEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? '',
                        child: Text(e.name ?? ''),
                      );
                    }).toList(),
                  ),
                  const Text('Serviços', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedServices,
                    hint: const Text("Selecione um serviço"),
                    onChanged: (value) {
                      setState(() {
                        final select = itemsServices.firstWhere((element) => element.name == value);
                        selectedServices = select.name;
                        selectedServicesId = select.id;
                      });
                    },
                    items: itemsServices.map((ServicesEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? '',
                        child: Text('${e.name} - R\$${e.price?.toStringAsFixed(2)}'),
                      );
                    }).toList(),
                  ),
                  const Text('Horários', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedHour,
                    hint: const Text("Selecione um horário"),
                    onChanged: (value) {
                      setState(() {
                        final select = itemsHours.firstWhere((element) => element.time == value);
                        selectedHour = select.time;
                        selectedHourId = select.id;
                      });
                    },
                    items: itemsHours.map((HoursActiveEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.time ?? '',
                        child: Text('${e.time}'),
                      );
                    }).toList(),
                  ),
                  const Text('Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedPay,
                    hint: const Text("Selecione um pagamento"),
                    onChanged: (value) {
                      setState(() {
                        final select = itemsPay.firstWhere((element) => element.name == value);
                        selectedPay = select.name;
                        selectedPayId = select.id;
                      });
                    },
                    items: itemsPay.map((PaymentMethodsEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? '',
                        child: Text('${e.name}'),
                      );
                    }).toList(),
                  ),
                   EasyInfiniteDateTimeLine(
                    //initialDate: DateTime.now(),
                    dayProps: const EasyDayProps(
                      dayStructure: DayStructure.dayNumDayStr,
                    ),
                    activeColor: AppColors.buttonColor,
                    onDateChange: (selectedDate){
                      setState(() {
                        print(selectedDate);
                        selectDate = selectedDate;
                      });
                    },
                    locale: "pt-br", 
                    firstDate: Constants.firstDay, 
                    focusDate: selectDate, 
                    lastDate: Constants.lastDay,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          message: 'Cancelar', 
                          buttonColor: AppColors.primaryColor, 
                          messageColor: AppColors.secundaryColorText,
                          borderColor: AppColors.secundaryColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 16),
                        ButtonWidget(
                          message: 'Prosseguir', 
                          buttonColor: AppColors.buttonColor, 
                          messageColor: AppColors.primaryColorText,
                          onPressed: () {
                            cubit.saveSchedule(
                              selectDate: formatarData(selectDate), 
                              selectedServicesId: selectedServicesId!, 
                              selectedBarberId: selectedBarberId!, 
                              selectedPayId: selectedPayId!
                            );
                            print("${AppRoutes.authModule}${AppRoutes.createUser}");
                            Modular.to.pushNamed("${AppRoutes.authModule}${AppRoutes.createUser}",);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('state.error.message.toString()'));
          //return Container();
        },
      ),
    );
  }
}
