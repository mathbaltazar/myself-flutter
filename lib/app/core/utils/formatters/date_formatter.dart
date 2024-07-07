import 'package:intl/intl.dart';

String _pattern(isDatabase) => isDatabase ? 'yyyy-MM-dd' : 'dd/MM/yyyy';
String get _dateTimePattern => 'yyyy-MM-dd HH:mm:ss';

extension DateTimeParser on String {
  DateTime parseFormatted({bool database = false}) =>
      DateFormat(_pattern(database)).parse(this);

  DateTime parseDateTime() => DateFormat(_dateTimePattern).parse(this);
}

extension FormatDate on DateTime {
  String format({bool database = false}) =>
      DateFormat(_pattern(database)).format(this);

  String formatYearMonthExtended() {
    final formatted = DateFormat('MMMM yyyy', 'pt_BR').format(this);
    return formatted.substring(0, 1).toUpperCase() + formatted.substring(1);
  }

  String formatYearMonth() {
    final formatted = DateFormat('MMM/yyyy', 'pt_BR').format(this);
    return formatted.substring(0, 1).toUpperCase() + formatted.substring(1);
  }

  String formatDateTime() => DateFormat(_dateTimePattern).format(this);
}
