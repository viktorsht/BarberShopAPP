import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateCostumerPage extends StatefulWidget {
  const CreateCostumerPage({super.key});

  @override
  State<CreateCostumerPage> createState() => _CreateCostumerPageState();
}

class _CreateCostumerPageState extends State<CreateCostumerPage> {

  final CreateCustomerBloc bloc = Modular.get<CreateCustomerBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Cadastro'),
      body: Container(),
    );
  }
}