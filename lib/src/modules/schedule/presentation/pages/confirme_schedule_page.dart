import 'package:client_barber_shop/src/common_widgets/button_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../common_widgets/app_bar_widget.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/scheduled_time.dart';
import '../bloc/schedule_bloc.dart';

class ConfirmeSchedule extends StatefulWidget {
  final ScheduleBloc controller;

  const ConfirmeSchedule({super.key, required this.controller});

  @override
  State<ConfirmeSchedule> createState() => _ConfirmeScheduleState();
}

class _ConfirmeScheduleState extends State<ConfirmeSchedule> {

  void showSnackBar(String message, Color color){
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool loading = false;

  @override
  void initState() {
    super.initState();
    widget.controller.add(ConfirmeScheduleEvent());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget(title: 'Finalizando agendamento'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder(
            bloc: widget.controller,
            builder: (context, state) {
              if(state is ConfirmeLoadingState){
                print('object');
                return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor,));
              }
              if(state is ConfirmeErrorState){
                return Center(child: Text("Error: ${state.error.toString()}"));
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
              //return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor,));
              return Container();
            },
          ),
          /*BlocBuilder(
            bloc: widget.controller,
            builder: (context, state){
              if(state is CreateScheduleLoadingState){
                return Center(child: CircularProgressIndicator(color: AppColors.secundaryColor,),);
              }
              return Container();
            }
          ),*/
          BlocListener(
            bloc: widget.controller,
            listener: (context, state){
                print('object');

              if(state is CreateScheduleErrorState){
                showSnackBar('Não foi possivel agendar', Colors.red);
              }
              if(state is CreateScheduleLoadingState){
                setState(() {
                  loading = true;
                });
                showSnackBar('Agendamento enviado, aguarde', Colors.green);
              }
              if(state is CreateScheduleState){
                const snackBar = SnackBar(
                  content: Text('Agendamento confirmado'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.green,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((reason) {
                  Modular.to.pushNamed(AppRoutes.homeModule);//${AppRoutes.schedule}");
                });
              }
            },
            child: loading == true ? Center(child: CircularProgressIndicator(color: AppColors.secundaryColor,),) : Container(),
          ),
        ],
      )
    );
  }
}