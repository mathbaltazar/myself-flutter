class DateFormatter {
  static DateTime parseFormatted(String s) {
    var day = int.parse(s.substring(0, 2));
    var month = int.parse(s.substring(3, 5));
    var year = int.parse(s.substring(6, 10));

    return DateTime(year, month, day);
  }
}

extension FormatDate on DateTime {
  String format() {
    String formatted = '${day < 10 ? '0$day' : day}/';
    formatted += '${month < 10 ? '0$month' : month}/';
    formatted += '$year';

    return formatted;
  }
}