part of 'create_costumer_bloc.dart';

@immutable
sealed class BlocEvent {}

class CreateCustomerEvent extends BlocEvent{
  final CustomerEntity user;

  CreateCustomerEvent(this.user);
}