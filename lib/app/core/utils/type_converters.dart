import 'package:intl/intl.dart';

final DateFormat _defaultDateConverter = DateFormat('yyyy-MM-dd');
extension StringToDateConverter on String {
  DateTime parseDate() {
    return _defaultDateConverter.parse(this);
  }
}
extension DateToStringConverter on DateTime {
  String toDateString() {
    return _defaultDateConverter.format(this);
  }
}
