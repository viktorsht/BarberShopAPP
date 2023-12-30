String formatPhoneNumber(String phone) {
  //String phoneNumberString = phoneNumber.toString();

  if (phone.length == 11) {
    return '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
  } else {
    return 'Formato de telefone inválido';
  }
}