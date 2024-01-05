import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/services_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:client_barber_shop/src/routes/app_routes.dart';
import 'package:client_barber_shop/src/utils/shared.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../common_widgets/button_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/scheduled_time.dart';
import '../../domain/entities/hours_active_entity.dart';
import '../bloc/hours/hours_bloc.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleBloc scheduleBloc;
  final HoursBloc hoursBloc;

  const SchedulePage({Key? key, required this.scheduleBloc, required this.hoursBloc}) : super(key: key);

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
    widget.scheduleBloc.add(ScheduleEvent());
    widget.hoursBloc.add(HoursScheduleEvent(selectDate.weekday));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ScheduleBloc, BlocState>(
            bloc: widget.scheduleBloc,
            builder: (context, state) {
              if (state is ScheduleErrorState) {
                return Center(child: Text(state.error.toString()));
              }
              if (state is ScheduleLoadingState) {
                return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor));
              }
              if (state is ScheduleSucessState) {
                
                final itemsBarbers = state.barber;
                final itemsServices = state.services;

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
                      const SizedBox(height: 16,),
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
                    ],
                  ),
                );
              }
              return const Center(child: Text('state.error.message.toString()'));
              //return Container();
            },
          ),
          BlocBuilder<HoursBloc, HoursBlocState>(
              bloc: widget.hoursBloc,
              builder: (context, state) {
                if(state is HoursSucessStatee){
                  final itemsHours = state.hours;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 16),
                    child: Column(
                      children: [
                        const Text('Horários', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        DropdownButtonFormField<String>(
                          value: selectedHour,
                          hint: itemsHours.isEmpty ? const Text("Não há horário disponível para hoje") : const Text("Selecione um horário"),
                          onChanged: (value) {
                            setState(() {
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
                      ],
                    ),
                  );
                }
                if(state is HoursLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Container();
              }
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: EasyInfiniteDateTimeLine(
                dayProps: const EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                ),
                activeColor: AppColors.buttonColor,
                onDateChange: (selectedDate){
                  if(selectedDate.weekday != 7){ // lógica de negócio que deveria estar em outro lugar
                    setState(() {
                      selectDate = selectedDate;
                      widget.hoursBloc.add(HoursScheduleEvent(selectDate.weekday));
                    });
                  }
                },
                locale: "pt-br", 
                firstDate: Constants.firstDay, 
                focusDate: selectDate, 
                lastDate: Constants.lastDay,
              ),
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
                    if(selectedServicesId == 0 || selectedBarberId == 0 || selectedHour == null){
                      showSnackBar('Selecione todos os campos', Colors.red);
                    }
                    else{
                      await SchedulePreferencesHelper.saveScheduleInfo(
                        scheduledTime: formatarData(selectDate, selectedHour ?? ''),
                        service: selectedServicesId ?? 0,
                        barber: selectedBarberId ?? 0,
                      );
                      if(await SharedPreferencesHelper.hasCustomer() == true){
                        Modular.to.navigate("${AppRoutes.scheduleModule}${AppRoutes.confirme}",);
                      }
                      else{
                        Modular.to.pushNamed("${AppRoutes.authModule}${AppRoutes.createUser}",);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
