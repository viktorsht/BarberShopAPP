String formatPhoneNumber(int phoneNumber) {
  String phoneNumberString = phoneNumber.toString();

  if (phoneNumberString.length == 11) {
    return '(${phoneNumberString.substring(0, 2)}) ${phoneNumberString.substring(2, 7)}-${phoneNumberString.substring(7)}';
  } else {
    return 'Invalid phone number format';
  }
}