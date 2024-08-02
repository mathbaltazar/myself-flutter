import 'package:signals/signals.dart';

extension SignalsExtensions<T> on Signal<T> {
  /// Notifies the listeners of this signal, if any, with its current value.
  void refresh() => set(get(), force: true);
}