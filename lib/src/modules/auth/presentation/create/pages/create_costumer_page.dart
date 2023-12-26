import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/text_form_field_widget.dart';

class CreateCostumerPage extends StatefulWidget {
  final CreateCustomerBloc controller;

  const CreateCostumerPage({
    super.key, 
    required this.controller
  });

  @override
  State<CreateCostumerPage> createState() => _CreateCostumerPageState();
}

class _CreateCostumerPageState extends State<CreateCostumerPage> {

  //final CreateCustomerBloc bloc = Modular.get<CreateCustomerBloc>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Cadastro'),
      body: Column(
        children: [
          WidgetFormField(hint: '', value: '',),
          WidgetFormField(hint: '', value: '',),
        ],
      ),
    );
  }
}