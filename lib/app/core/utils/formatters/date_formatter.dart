import 'dart:io';

import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String format() => DateFormat('dd/MM/yyyy', Platform.localeName).format(this);

  String formatYearMonthExtended() {
    final formatted = DateFormat('MMMM yyyy', Platform.localeName).format(this);
    return formatted.substring(0, 1).toUpperCase() + formatted.substring(1);
  }
}
