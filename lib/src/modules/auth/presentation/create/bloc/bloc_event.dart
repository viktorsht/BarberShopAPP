part of 'create_costumer_bloc.dart';

@immutable
sealed class BlocEvent {}

class CreateCustomerEvent extends BlocEvent{
  final CreateCustomerEntity user;

  CreateCustomerEvent(this.user);
}