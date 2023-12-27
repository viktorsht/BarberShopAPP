part of 'update_costumer_bloc.dart';

@immutable
sealed class BlocState {}

final class UpdateCostumerInitial extends BlocState {}

class UpdateCostumerErrorState extends BlocState {
  final ResponsePresentation error;

  UpdateCostumerErrorState({required this.error});
}

class UpdateCostumerSucessState extends BlocState {
  final ResponsePresentation data;

  UpdateCostumerSucessState({required this.data});
}

class UpdateCostumerLoadingState extends BlocState {
  UpdateCostumerLoadingState();
}
