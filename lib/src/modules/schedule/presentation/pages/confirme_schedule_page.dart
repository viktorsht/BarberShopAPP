import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/schedule_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/app_bar_widget.dart';
import '../bloc/schedule_bloc.dart';

class ConfirmeSchedule extends StatefulWidget {
  final ScheduleBloc controller;

  const ConfirmeSchedule({super.key, required this.controller});

  @override
  State<ConfirmeSchedule> createState() => _ConfirmeScheduleState();
}

class _ConfirmeScheduleState extends State<ConfirmeSchedule> {
  @override
  void initState() {
    super.initState();
    widget.controller.add(ConfirmeScheduleEvent());
  }
  @override
  Widget build(BuildContext context) {
    ScheduleEntity entity = ScheduleEntity();
    String phone = '';

    return Scaffold(
      appBar: const AppBarWidget(title: 'Finalizando agendamento'),
      body: BlocBuilder(
        bloc: widget.controller,
        builder: (context, state) {
          if(state is ConfirmeSucessState){
            return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              color: AppColors.secundaryColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalhes do Agendamento',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Data e Hora: ${entity.scheduledTime ?? "Não especificado"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Serviço: ${entity.service ?? "Não especificado"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Barbeiro: ${entity.service ?? "Não especificado"}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Telefone: $phone',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
          }
          return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor,));
        },
        //child: 
      )
    );
  }
}