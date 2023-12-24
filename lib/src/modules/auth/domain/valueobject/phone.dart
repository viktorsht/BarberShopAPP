import 'package:client_barber_shop/src/utils/value_object.dart';

class Phone implements ValueObject {
  final String _value;
  static final RegExp _emailRegex = RegExp(r'^\(\d{2}\) \d{4}-\d{4}$');

  Phone(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Este campo não pode ser vazio';
    } else if (!_emailRegex.hasMatch(_value)) {
      return 'Formato de telefone inválido';
    }
    return null;
  }

  @override
  String toString() => _value;
}