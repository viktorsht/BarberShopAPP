
import '../../../../external/response/response_presentation.dart';
import '../entities/customer_entity.dart';

abstract class AuthRepository{
  Future<ResponsePresentation> createCustomer(CustomerEntity entity);
  Future<ResponsePresentation> updateCustomer(int userId, CustomerEntity entity);
}