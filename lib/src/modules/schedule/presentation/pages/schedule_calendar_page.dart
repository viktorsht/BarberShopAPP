import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../common_widgets/app_bar_widget.dart';
import '../../../../common_widgets/button_widget.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/scheduled_time.dart';
import '../../domain/entities/hours_active_entity.dart';
import '../bloc/schedule_bloc.dart';

class ScheduleCalendarPage extends StatefulWidget {
  final ScheduleBloc controller;
  const ScheduleCalendarPage({super.key, required this.controller});

  @override
  State<ScheduleCalendarPage> createState() => _ScheduleCalendarPageState();
}

class _ScheduleCalendarPageState extends State<ScheduleCalendarPage> {

  String? selectedHour;
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.controller.add(HoursScheduleEvent(selectDate.weekday));
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: const AppBarWidget(title: 'Agendar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyInfiniteDateTimeLine(
              dayProps: const EasyDayProps(
                dayStructure: DayStructure.dayNumDayStr,
              ),
              activeColor: AppColors.buttonColor,
              onDateChange: (selectedDate){
                if(selectedDate.weekday != 7){ // lógica de negócio que deveria estar em outro lugar
                  setState(() {
                    selectDate = selectedDate;
                    widget.controller.add(HoursScheduleEvent(selectDate.weekday));
                  });
                }
              },
              locale: "pt-br", 
              firstDate: Constants.firstDay, 
              focusDate: selectDate, 
              lastDate: Constants.lastDay,
            ),
            const SizedBox(height: 16,),
            BlocBuilder<ScheduleBloc, BlocState>(
              bloc: widget.controller,
              builder: (context, state) {
                if(state is HoursSucessStatee){
                  final itemsHours = state.hours;
                  return Column(
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
                  );
                }
                if(state is HoursLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Container();
              }
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
                      if(selectedHour != '' || selectedHour != null){
                        String hourFormated = formatarData(selectDate, selectedHour ?? '');
                        Modular.to.pushNamed("${AppRoutes.scheduleModule}${AppRoutes.schedule}", arguments: hourFormated);
                      }
                      /*if(selectedServicesId == 0 || selectedBarberId == 0){
                        showSnackBar('Selecione todos os campos', Colors.red);
                      }
                      else{
                        await SchedulePreferencesHelper.saveScheduleInfo(
                          scheduledTime: widget.scheduledTime,//formatarData(selectDate, selectedHour?? ''),
                          service: selectedServicesId ?? 0,
                          barber: selectedBarberId ?? 0,
                        );
                        if(await SharedPreferencesHelper.hasCustomer() == true){
                          Modular.to.navigate("${AppRoutes.scheduleModule}${AppRoutes.schedule}",);
                        }
                        else{
                          Modular.to.pushNamed("${AppRoutes.authModule}${AppRoutes.createUser}",);
                        }
                        */
                      //}
                      //print("${AppRoutes.authModule}${AppRoutes.createUser}");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}