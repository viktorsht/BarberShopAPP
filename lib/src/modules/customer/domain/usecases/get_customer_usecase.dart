import '../../../../external/response/response_presentation.dart';

abstract class GeuUsersUseCase{
  Future<ResponsePresentation> call(int id);
}