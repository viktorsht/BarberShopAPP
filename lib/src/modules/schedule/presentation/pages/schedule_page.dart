import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/payment_methods_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/services_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    widget.controller.add(ScheduleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Agendar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ScheduleBloc, BlocState>(
          bloc: widget.controller,
          builder: (context, state) {
            if (state is ScheduleErrorState) {
              return Text(state.error.message.toString());
            }
            if (state is ScheduleLoadingState) {
              return const CircularProgressIndicator();
            }
            if (state is ScheduleSucessState) {
              final itemsBarbers = state.barber;
              final itemsServices = state.services;
              final itemsPay = state.pay;
        
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
                        value: e.name,
                        child: Text(e.name!),
                      );
                    }).toList(),
                  ),
                  const Text('Serviços', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedServices,
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (value) {
                      setState(() {
                        selectedServices = value;
                      });
                    },
                    items: itemsServices.map((ServicesEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name,
                        child: Text(e.name!),
                      );
                    }).toList(),
                  ),
                  const Text('Métodos de Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedPay,
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (value) {
                      setState(() {
                        selectedPay = value;
                      });
                    },
                    items: itemsPay.map((PaymentMethodsEntity e) {
                      return DropdownMenuItem<String>(
                        value: e.name,
                        child: Text(e.name!),
                      );
                    }).toList(),
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
