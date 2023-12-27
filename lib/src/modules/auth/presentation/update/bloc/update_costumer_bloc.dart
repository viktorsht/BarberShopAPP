import 'package:bloc/bloc.dart';
import 'package:client_barber_shop/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../../../../external/response/response_presentation.dart';
import '../../../domain/entities/customer_entity.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class UpdateCostumerBloc extends Bloc<BlocEvent, BlocState>{
  final AuthRepository authRepository;
  UpdateCostumerBloc(this.authRepository) : super(UpdateCostumerInitial()){
    on<UpdateCustomerEvent> (_mapEventToState);
  }

  void _mapEventToState(UpdateCustomerEvent event, Emitter<BlocState> emit) async {
    emit(UpdateCostumerLoadingState());
    try{
      await authRepository.updateCustomer(event.userId, event.user);
    }
  }

}