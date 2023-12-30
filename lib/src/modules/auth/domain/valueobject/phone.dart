import 'package:client_barber_shop/src/utils/value_object.dart';

import '../../../../utils/phone_utils.dart';

class Phone implements ValueObject {
  final String _value;
  static final RegExp _phoneRegex = RegExp(r'^\(\d{2}\) \d{4}-\d{4}$');

  Phone(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Adicione um número de telefone';
    } else if (!_phoneRegex.hasMatch(formatPhoneNumber(_value))) {
      return 'Formato de telefone inválido';
    }
    return null;
  }

  @override
  String toString() => _value;
}