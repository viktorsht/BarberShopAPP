import 'package:client_barber_shop/src/common_widgets/button_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/app_bar_widget.dart';
import '../../../../utils/scheduled_time.dart';
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
    //widget.controller.add(CreateScheduleEvent());
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget(title: 'Finalizando agendamento'),
      body: BlocBuilder(
        bloc: widget.controller,
        builder: (context, state) {
          if(state is ScheduleLoadingState){
            return const Text('data');
          }
          if(state is ScheduleErrorState){
            return Center(child: Text("Error: ${state.error.message.toString()}"));
          }
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
                          'Deseja agendar para ${formatarDataHora(state.entity.scheduledTime!)}?',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 26.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ButtonWidget(
                            message: 'Agendar', 
                            buttonColor: AppColors.primaryColor, 
                            messageColor: AppColors.secundaryColor, 
                            onPressed: (){
                              widget.controller.add(CreateScheduleEvent(state.entity));
                            },
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