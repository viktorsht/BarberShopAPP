class Api {
  static String urlApi = 'http://10.0.0.20:8080/api/v1/';
}
class RoutesApi{
  
  static String schedule = '${Api.urlApi}schedules';
  static String clients = '${Api.urlApi}clients';
  static String services = '${Api.urlApi}services';
  static String barbers = '${Api.urlApi}barbers';
  static String paymentMethods = '${Api.urlApi}paymentMethods';
  static String hoursActive = '${Api.urlApi}hoursActive';
  static String hours = '${Api.urlApi}hours';

}