extension InlineAlso<T> on T {
  T also(void Function(T) command) {
    command(this);
    return this;
  }
}
extension InlineLet<T, R> on T {
  R let(R Function(T) command) {
    return command(this);
  }
}