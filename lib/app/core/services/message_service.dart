import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageService {
  static showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      elevation: 12,
    ));
  }
}
