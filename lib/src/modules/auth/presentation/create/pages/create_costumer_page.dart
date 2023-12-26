import 'package:client_barber_shop/src/common_widgets/app_bar_widget.dart';
import 'package:client_barber_shop/src/constants/app_colors.dart';
import 'package:client_barber_shop/src/constants/app_images.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/name.dart';
import 'package:client_barber_shop/src/modules/auth/domain/valueobject/phone.dart';
import 'package:client_barber_shop/src/modules/auth/presentation/create/bloc/create_costumer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/button_widget.dart';
import '../../../../../common_widgets/text_form_field_widget.dart';
import '../../../domain/entities/create_customer_entity.dart';

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo, 
                    width: 500, 
                    height: 200,
                  )
                ),
                const Center(
                  child: Text(
                    "Cadastro",
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
                  value: entity.phone!.toString(),
                  onChanged: (p0) =>  entity.phone = Phone(p0),
                  validator: (p0) => entity.phone!.validator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          onPressed: (){
                            final valid = form.validate();
                            if(!valid){
                              widget.controller.add(CreateCustomerEvent(entity));
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
                BlocBuilder(
                  bloc: widget.controller,
                  builder: (context, state){
                  if(state is CreateCostumerErrorState){
                    return Text(state.error.message.toString());
                  }
                  if(state is CreateCostumerLoadingState){
                    return const CircularProgressIndicator();
                  }
                  return Container();
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}