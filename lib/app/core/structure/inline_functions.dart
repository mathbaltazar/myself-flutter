extension InlineAlso<T> on T {
  T also(void Function(T) command) {
    command(this);
    return this;
  }
}
