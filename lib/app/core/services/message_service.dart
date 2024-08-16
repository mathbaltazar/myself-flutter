import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myselff_flutter/app/core/extensions/object_extensions.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState>? _messenger;
  static GlobalKey<ScaffoldMessengerState> get instance => _messenger ??= GlobalKey();

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

    _messenger!.currentContext
        ?.let((context) => _messenger!.currentState!.showSnackBar(SnackBar(
              duration: _defaultDuration,
              behavior: SnackBarBehavior.floating,
              content: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.white70),
                  const SizedBox(width: 10),
                  Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              elevation: 12,
              shape: _defaultShapeBorder,
              backgroundColor: Theme.of(context).colorScheme.error,
            )));
  }
}