part of 'update_costumer_bloc.dart';

@immutable
sealed class BlocEvent {}

class UpdateCustomerEvent extends BlocEvent{
  final CustomerEntity user;

  UpdateCustomerEvent(this.user);
}