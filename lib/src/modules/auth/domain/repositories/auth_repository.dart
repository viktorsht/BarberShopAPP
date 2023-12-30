
import '../../../../external/response/response_presentation.dart';
import '../entities/customer_entity.dart';
import '../entities/data_client.dart';

abstract class AuthRepository{
  Future<ResponsePresentation> createCustomer(CustomerEntity entity);
  Future<DataClient> fetchCustomer(String phone);
  Future<ResponsePresentation> updateCustomer(int userId, CustomerEntity entity);
}