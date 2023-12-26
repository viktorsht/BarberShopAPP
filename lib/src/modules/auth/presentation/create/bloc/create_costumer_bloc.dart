import 'package:bloc/bloc.dart';
import 'package:client_barber_shop/src/external/response/response_presentation.dart';
import 'package:client_barber_shop/src/modules/auth/domain/entities/customer_entity.dart';
import 'package:client_barber_shop/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class CreateCustomerBloc extends Bloc<BlocEvent, BlocState> {

  final AuthRepository authRepository;
  
  CreateCustomerBloc(this.authRepository) : super(CreateCostumerInitial()) {
    on<CreateCustomerEvent> (_mapEventToState);
  }

  void _mapEventToState(CreateCustomerEvent event, Emitter<BlocState> emit) async {
    emit(CreateCostumerLoadingState());
    try{
      final data = await authRepository.createCustomer(event.user);
      emit(CreateCostumerSucessState(data: data));
    }
    on ResponsePresentation catch (e){
      print(e.message);
      emit(CreateCostumerErrorState(error: e));
    }
  } 
} 