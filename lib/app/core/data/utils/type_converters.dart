import 'package:intl/intl.dart';

extension TypeConverters on Object? {
  double parseDouble() {
    return double.parse(toString());
  }

  bool parseBoolean() {
    return toString() == '1'
        ? true
        : toString() == '0'
            ? false
            : throw TypeConverterException('Invalid boolean'); //
  }

}

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

class TypeConverterException {
  TypeConverterException(String message);
}
