part of 'update_costumer_bloc.dart';

@immutable
sealed class BlocEvent {}

class UpdateCustomerEvent extends BlocEvent{
  final Phone phone;
  final CustomerEntity user;

  UpdateCustomerEvent(this.user, this.phone);
}