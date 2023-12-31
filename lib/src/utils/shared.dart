import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String clientNameKey = 'clientName';
  static const String clientPhoneKey = 'clientPhone';

  // Método para salvar o nome do cliente e telefone
  static Future<void> saveClientInfo(String clientName, String clientPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(clientNameKey, clientName);
    await prefs.setString(clientPhoneKey, clientPhone);
  }

  // Método para recuperar o nome do cliente salvo
  static Future<String?> getClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(clientNameKey);
  }

  // Método para recuperar o telefone do cliente salvo
  static Future<String?> getClientPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(clientPhoneKey);
  }

  static Future<bool> hasCustomer() async{
    final name = await getClientName();
    final phone = await getClientPhone();
    return name != null && phone != null ? true : false;
  }
}


class SchedulePreferencesHelper {
  static const String scheduledTimeKey = 'scheduledTime';
  static const String serviceKey = 'service';
  static const String barberKey = 'barber';

  // Método para salvar os campos do agendamento
  static Future<void> saveScheduleInfo({
    required String scheduledTime,
    required int service,
    required int barber,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(scheduledTimeKey, scheduledTime);
    await prefs.setInt(serviceKey, service);
    await prefs.setInt(barberKey, barber);
  }

  // Método para recuperar o horário agendado
  static Future<String?> getScheduledTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(scheduledTimeKey);
  }

  // Método para recuperar o serviço agendado
  static Future<int?> getService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(serviceKey);
  }

  // Método para recuperar o barbeiro agendado
  static Future<int?> getBarber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(barberKey);
  }
}
