
import '../../../../external/response/response_presentation.dart';
import '../entities/create_customer_entity.dart';

abstract class AuthRepository{
  Future<ResponsePresentation> createCustomer(CreateCustomerEntity createCustomerEntity);
}