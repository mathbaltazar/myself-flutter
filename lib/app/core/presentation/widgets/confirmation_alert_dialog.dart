import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/structure/inline_functions.dart';

class ConfirmationAlertDialog extends StatelessWidget {
  const ConfirmationAlertDialog({
    super.key,
    this.icon,
    required this.title,
    this.content,
    this.confirmLabel,
    this.confirmLabelTextStyle,
    this.confirmButtonOutline = true,
    required this.onConfirm,
    this.onCancel,
  });

  final Icon? icon;
  final String title;
  final String? content;
  final String? confirmLabel;
  final TextStyle? confirmLabelTextStyle;
  final bool confirmButtonOutline;
  final Function()? onCancel;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: icon,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      content: content?.let((it) => Text(it, textAlign: TextAlign.center)),
      actions: [
        Visibility(
          visible: onCancel != null,
          child: TextButton(
            onPressed: onCancel,
            child: const Text('Cancelar'),
          ),
        ),
        TextButton(
            onPressed: onConfirm,
            child: Text(
              confirmLabel ?? 'Confirmar',
              style: confirmLabelTextStyle,
            )),
      ],
    );
  }
}
