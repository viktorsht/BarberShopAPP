import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/constants/constants.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/services_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:client_barber_shop/src/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../../../../common_widgets/button_widget.dart';
import '../../../../utils/scheduled_time.dart';
import '../../domain/entities/hours_active_entity.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleBloc controller;

  const SchedulePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  

  String? selectedBarber;
  int? selectedBarberId;
  
  String? selectedServices;
  int? selectedServicesId;

  String? selectedPay;
  int? selectedPayId;
  
  String? selectedHour;
  
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.controller.add(ScheduleEvent());
  }

  void showSnackBar(String message, Color color){
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Barbeiro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedBarber,
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (value) {
                      final select = itemsBarbers.firstWhere((element) => element.name == value);
                      setState(() {
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
                      final select = itemsServices.firstWhere((element) => element.name == value);
                      setState(() {
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
                        //final select = itemsHours.firstWhere((element) => element.time == value);
                        selectedHour = value;
                      });
                    },
                    items: itemsHours.map((HoursActiveEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.time ?? '',
                        child: Text('${e.time}'),
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
                          onPressed: () async {
                            if(selectedHour == '' || selectedServicesId == 0 || selectedBarberId == 0){
                              showSnackBar('Selecione todos os campos', Colors.red);
                            }
                            else{
                              await SchedulePreferencesHelper.saveScheduleInfo(
                                scheduledTime: formatarData(selectDate, selectedHour?? ''),
                                service: selectedServicesId ?? 0,
                                barber: selectedBarberId ?? 0,
                              );
                              if(await SharedPreferencesHelper.hasCustomer() == true){
                                Modular.to.pushNamed("${AppRoutes.scheduleModule}${AppRoutes.schedule}",);
                              }
                              else{
                                Modular.to.pushNamed("${AppRoutes.authModule}${AppRoutes.createUser}",);
                              }
                            }
                            //print("${AppRoutes.authModule}${AppRoutes.createUser}");
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
