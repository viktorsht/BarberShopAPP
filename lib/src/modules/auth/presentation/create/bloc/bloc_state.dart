part of 'create_costumer_bloc.dart';


@immutable
sealed class BlocState {}

final class CreateCostumerInitial extends BlocState {}

class CreateCostumerErrorState extends BlocState {
  final String message;

  CreateCostumerErrorState({required this.message});
}

class CreateCostumerSucessState extends BlocState {
  final ResponsePresentation data;

  CreateCostumerSucessState({required this.data});
}

class CreateCostumerLoadingState extends BlocState {
  CreateCostumerLoadingState();
}
