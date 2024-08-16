import 'package:flutter/material.dart';
import '../../extensions/object_extensions.dart';
import '../mixins/dialog_mixin.dart';

class ConfirmationAlertDialog extends StatelessWidget
    with StatelessWidgetDialogMixin {
  const ConfirmationAlertDialog({
    super.key,
    this.icon,
    required this.title,
    this.content,
    this.confirmLabel,
    this.confirmLabelTextStyle,
    required this.onConfirm,
    this.onCancel,
  });

  final Icon? icon;
  final String title;
  final String? content;
  final String? confirmLabel;
  final TextStyle? confirmLabelTextStyle;
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
