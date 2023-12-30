import 'package:intl/intl.dart';

String formatarData(DateTime data) {
  //DateTime data = DateTime.parse(dataString);
  String dataFormatada = DateFormat('dd-MM-yyyy').format(data);
  return dataFormatada;
}