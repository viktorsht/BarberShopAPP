import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/name.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/phone.dart';
import 'package:client_barber_shop/src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../common_widgets/button_widget.dart';
import '../../../../../common_widgets/text_form_field_widget.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../utils/shared.dart';
import '../../../domain/entities/customer_entity.dart';

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

  CustomerEntity entity = CustomerEntity.empty();
  final formKey = GlobalKey<FormState>();
  FormState get form => formKey.currentState!;

  void showSnackBar(String message, Color color){
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: const AppBarWidget(title: 'Cadastro'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Finalize seu cadastro",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),
              const Text("Nome"),
              WidgetFormField(
                hint: 'Nome', 
                value: entity.name!.toString(),
                onChanged: (p0) => entity.name = Name(p0),
                validator:(p0) => entity.name!.validator(),
              ),
              const SizedBox(height: 16,),
              const Text("Telefone"),
              WidgetFormField(
                hint: 'Telefone', 
                value: entity.phone!.value,
                onChanged: (p0) =>  entity.phone = Phone(p0),
                validator: (p0) => entity.phone!.validator(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(
                        message: 'Cancelar', 
                        buttonColor: AppColors.primaryColor, 
                        messageColor: AppColors.secundaryColorText,
                        borderColor: AppColors.secundaryColor,
                        onPressed: (){
                          entity.name = Name('');
                          entity.phone = Phone('');
                        },
                      ),
                      const SizedBox(width: 16),
                      ButtonWidget(
                        message: 'Cadastrar', 
                        buttonColor: AppColors.buttonColor, 
                        messageColor: AppColors.primaryColorText,
                        onPressed: () async {
                          final valid = form.validate();
                          if(valid){
                            widget.controller.add(CreateCustomerEvent(entity));
                            await SharedPreferencesHelper.saveClientInfo(
                              entity.name.toString(), 
                              entity.phone.toString()
                            );
                          }
                          else{
                            showSnackBar('Dados inválidos', Colors.red);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocListener(
                bloc: widget.controller,
                listener: (context, state){
                  if(state is CreateCostumerErrorState){
                    showSnackBar('Houve um erro no seu cadastro', Colors.red);
                  }
                  if(state is CreateCostumerLoadingState){
                    showSnackBar('Cadastro enviado', Colors.green);
                  }
                  if(state is CreateCostumerSucessState){
                    //showSnackBar('Cadastro realizado', Colors.green);
                    //Modular.to.pushNamed("${AppRoutes.scheduleModule}${AppRoutes.schedule}",);
                    const snackBar = SnackBar(
                      content: Text('Cadastro realizado'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((reason) {
                      // Navegar para a próxima tela após o Snackbar ser fechado
                      Modular.to.pushNamed("${AppRoutes.scheduleModule}${AppRoutes.schedule}");
                    });
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}