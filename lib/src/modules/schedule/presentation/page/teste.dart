import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/bloc_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/schedule_entity.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  final BlocSchedule blocBooks = Modular.get<BlocSchedule>();
  
  @override
  void initState() {
    // TODO: implement initState
    //blocBooks.add(PostScheduleEvent(scheduleEntity));
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<BlocSchedule, BlocState>(
        bloc: blocBooks,
        builder: (context, state) {
          if(state is ScheduleErrorState){
            return Text(state.message);
          }
          else if(state is ScheduleSucessState){
            return Text('ok');
          }
          return Container();
        },
      ),
    );
  }
}