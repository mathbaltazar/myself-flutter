import 'package:flutter/material.dart';

mixin StatelessWidgetDialogMixin on StatelessWidget {
  Future<T> showAdaptive<T>(context) async {
    return await showAdaptiveDialog(context: context, builder: (_) => this);
  }
}

mixin StatefulWidgetDialogMixin on StatefulWidget {
  Future<T> showAdaptive<T>(context) async {
    return await showAdaptiveDialog(context: context, builder: (_) => this);
  }
}
