import 'package:flutter/services.dart';
import 'formatters/currency_formatter.dart';

class MaskUtil {
  static TextInputFormatter currency() {
    return TextInputFormatter.withFunction((oldValue, TextEditingValue newValue) {
      String onlyDigits = newValue.text.replaceAll(RegExp('[^0-9]'), '');
      String formatted = (double.parse(onlyDigits) / 100).formatCurrency();
      return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length));
    });
  }
}