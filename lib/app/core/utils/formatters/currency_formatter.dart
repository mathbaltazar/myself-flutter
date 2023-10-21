import 'dart:io';

import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  static final _formatter =
      NumberFormat.currency(locale: Platform.localeName, symbol: '');

  String formatCurrency() {
    return _formatter.format(this).trim();
  }
}

extension CurrencyParser on String {
  double parseCurrency() {
    return double.parse(replaceAll(RegExp('[^0-9]'), '')) / 100;
  }
}