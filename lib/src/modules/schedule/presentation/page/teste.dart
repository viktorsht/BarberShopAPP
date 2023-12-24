import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/bloc_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/schedule_entity.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  final BlocSchedule blocSchedule = Modular.get<BlocSchedule>();

  final scheduleEntity = ScheduleEntity(
        id: 1,
        barber: 1,
        client: 2,
        scheduledDay: '2023-12-31 12:00:00',
        service: 3,
        paymentMethod: 4,
      );
  
  @override
  void initState() {
    super.initState();
    blocSchedule.add(PostScheduleEvent(scheduleEntity));
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: BlocBuilder<BlocSchedule, BlocState>(
          bloc: blocSchedule,
          builder: (context, state) {
            if(state is ScheduleErrorState){
              return Text(state.message);
            }
            else if(state is ScheduleSucessState){
              return const Text('ok');
            }
            return Container();
          },
        ),
      ),
    );
  }
}