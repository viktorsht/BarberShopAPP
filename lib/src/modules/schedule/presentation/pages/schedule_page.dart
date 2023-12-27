import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/modules/schedule/domain/entities/barber_entity.dart';
import 'package:client_barber_shop/src/modules/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleBloc controller;
  const SchedulePage({super.key, required this.controller});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    // passa um evento geral do bloc aqui
    widget.controller.add(ScheduleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Agendar'),
      body: BlocBuilder(
        bloc: widget.controller,
        builder: (context, state){
          if(state is ScheduleErrorState){
            return Text(state.error.message.toString());
          }
          if(state is ScheduleLoadingState){
            return const CircularProgressIndicator();
          }
          if(state is ScheduleSucessState){
            final itemsBarbers = state.barber;
            return Expanded(
              child: Column(
                children: [
                  const Text('Barbeiro'),
                  DropdownButtonFormField<String>(
                    hint: const Text("Selecione um barbeiro"),
                    onChanged: (String? value) {  },
                    items: itemsBarbers.map((BarberEntity e){
                      return DropdownMenuItem<String>(
                        value: e.name,
                        child: Text(e.name!),
                      );
                    } 
                    ).toList(), 
                  )
                ],
              )
            );
          }
          return Container();

        }
      ),
    );
  }
}