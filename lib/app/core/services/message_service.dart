import 'package:flutter/material.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState>? _messenger;
  static GlobalKey<ScaffoldMessengerState> instance(BuildContext context) {
    return _messenger ??= GlobalKey();
  }
  static showMessage(String message) {
    if (_messenger?.currentState == null) {
      throw 'Message service is not initialized';
    }
    _messenger!.currentState?.showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      elevation: 12,
    ));
  }
}