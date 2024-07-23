extension ListExtension<T> on List<T> {
  void replace(bool Function(T) predicate, T element) {
    final elementIndex = indexWhere(predicate);
    if (elementIndex >= 0) {
      setAll(elementIndex, [element]);
    }
  }
}
