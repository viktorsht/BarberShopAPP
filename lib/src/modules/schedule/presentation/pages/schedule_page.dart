import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/hours_active_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/payment_methods_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/services_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/button_widget.dart';
import 'package:table_calendar/table_calendar.dart';


class SchedulePage extends StatefulWidget {
  final ScheduleBloc controller;

  const SchedulePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? selectedBarber;
  String? selectedServices;
  String? selectedPay;
  String? selectedHour;

      CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    widget.controller.add(ScheduleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Agendar'),
      body: SingleChildScrollView(
        child: BlocBuilder<ScheduleBloc, BlocState>(
          bloc: widget.controller,
          builder: (context, state) {
            if (state is ScheduleErrorState) {
              return Text(state.error.message.toString());
            }
            if (state is ScheduleLoadingState) {
              return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor));
            }
            if (state is ScheduleSucessState) {
              final itemsBarbers = state.barber;
              final itemsServices = state.services;
              final itemsPay = state.pay;
              final itemsHour = state.hours;
        
              return Column(
                children: [
                  const Text('Barbeiro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedBarber,
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (value) {
                      setState(() {
                        selectedBarber = value;
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
                        selectedServices = value;
                      });
                    },
                    items: itemsServices.map((ServicesEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? '',
                        child: Text(e.name ?? ''),
                      );
                    }).toList(),
                  ),
                  const Text('Métodos de Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedPay,
                    hint: const Text("Selecione um método de pagamento"),
                    onChanged: (value) {
                      setState(() {
                        selectedPay = value;
                      });
                    },
                    items: itemsPay.map((PaymentMethodsEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? '',
                        child: Text(e.name ?? ''),
                      );
                    }).toList(),
                  ),
                  const Text('Horário', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedHour,
                    hint: const Text("Selecione um horário"),
                    onChanged: (value) {
                      setState(() {
                        selectedHour = value;
                      });
                    },
                    items: itemsHour.map((HoursActiveEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.time ?? '',
                        child: Text(e.time ?? ''),
                      );
                    }).toList(),
                  ),
                  TableCalendar(
                    calendarFormat: _calendarFormat,
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2024, 12, 31),
                    selectedDayPredicate: (day) {
                      // Use isso para destacar o dia selecionado
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      // Callback quando um dia é selecionado
                      print('Dia selecionado: $selectedDay');
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      // Personalize a aparência do dia
                      selectedBuilder: (context, date, _) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
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
                          message: 'Agendar', 
                          buttonColor: AppColors.buttonColor, 
                          messageColor: AppColors.primaryColorText,
                          onPressed: (){
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
