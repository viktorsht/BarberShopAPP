import 'package:intl/intl.dart';

String formatarData(DateTime data, String hours) {
  String dataFormatada = DateFormat('dd-MM-yyyy').format(data);
  return '$dataFormatada $hours';
}

String formatarDataHora(String dataHoraString) {
  DateTime dataHora = DateFormat('dd-MM-yyyy HH:mm:ss').parse(dataHoraString);
  
  String dia = DateFormat('d').format(dataHora);
  String horaMinuto = DateFormat('HH:mm').format(dataHora);
  
  return 'dia $dia às $horaMinuto horas';
}