extension TypeConverterParses on Object? {
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

class TypeConverterException {
  TypeConverterException(String message);
}
