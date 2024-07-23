import 'package:flutter/material.dart';

mixin DialogMixin on StatelessWidget {
  Future<T> showAdaptive<T>(context) async {
    return await showAdaptiveDialog(context: context, builder: (_) => this);
  }
}