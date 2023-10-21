extension DateTimeParser on String {
  DateTime parseFormatted({bool database = false}) {
    var day = database ? int.parse(substring(8, 10)) : int.parse(substring(0, 2));
    var month = database ? int.parse(substring(5, 7)) : int.parse(substring(3, 5));
    var year = database ? int.parse(substring(0, 4)) : int.parse(substring(6, 10));

    return DateTime(year, month, day);
  }
}

extension FormatDate on DateTime {
  String format({bool database = false}) {
    String formatted = '';
    if (database) {
      formatted += '$year';
      formatted += '-${month.toString().padLeft(2, '0')}';
      formatted += '-${day.toString().padLeft(2, '0')}';
    } else {
      formatted += day.toString().padLeft(2, '0');
      formatted += '/${month.toString().padLeft(2, '0')}';
      formatted += '/$year';
    }

    return formatted;
  }
}
