extension StringExtensions on String {
  double parseDouble() {
    return double.parse(this);
  }

  bool parseBool() {
    return this == '1' ? true : this == '0' ? false : throw FormatException('Cannot parse to boolean: $this');
  }

  String prefix(String value, {String separator = '_'}) {
    return '$value$separator$this';
  }
}
