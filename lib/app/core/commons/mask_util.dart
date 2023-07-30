import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskUtil {
  static TextInputFormatter currency() {
    return TextInputFormatter.withFunction((oldValue, TextEditingValue newValue) {
      String digits = '';
      String validDigits = '0123456789';
      for (String c in newValue.text.characters) {
        if (validDigits.contains(c)) {
          digits += c;
        }
      }

      String newTextValue = '\$ ${(double.parse(digits) / 100).toStringAsFixed(2)}';
      return TextEditingValue(
          text: newTextValue,
          selection: TextSelection.collapsed(offset: newTextValue.length));
    });
  }



}