import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState>? _messenger;
  static GlobalKey<ScaffoldMessengerState> instance() {
    return _messenger ??= GlobalKey();
  }

  static final _defaultShapeBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  static const _defaultDuration = Duration(milliseconds: 1500);

  static showMessage(String message) {
    if (_messenger?.currentState == null) {
      throw 'Message service is not initialized';
    }
    _messenger!.currentState!.showSnackBar(SnackBar(
      duration: _defaultDuration,
      behavior: SnackBarBehavior.floating,
      content: Text(message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          )),
      shape: _defaultShapeBorder,
      elevation: 12,
    ));
  }

  static showErrorMessage(String message) {
    if (_messenger?.currentState == null) {
      throw 'Message service is not initialized';
    }
    _messenger!.currentState!.showSnackBar(SnackBar(
      duration: _defaultDuration,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.info, color: Colors.white70),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      elevation: 12,
      shape: _defaultShapeBorder,
      backgroundColor: MyselffTheme.colorError,
    ));
  }
}