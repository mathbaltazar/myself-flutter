import 'package:flutter/foundation.dart';

abstract class IReactiveServiceBase<S> implements ValueListenable<S> {
  bool get hasListeners;

  void emit(S state);
}

class ReactiveService<S> implements IReactiveServiceBase<S> {
  ReactiveService(initialValue)
      : _notifier = ValueNotifier(initialValue);

  final ValueNotifier<S> _notifier;

  @override
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  @override
  void emit(S state) {
    _notifier.value = state;
  }

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  @override
  S get value => _notifier.value;

  @override
  // ignore: invalid_use_of_protected_member
  bool get hasListeners => _notifier.hasListeners;
}
