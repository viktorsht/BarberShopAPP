import 'package:client_barber_shop/src/utils/value_object.dart';

class Name implements ValueObject {
  final String _value;

  Name(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }

  @override
  String toString() => _value;
}