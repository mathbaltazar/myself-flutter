import 'package:flutter/material.dart';

mixin BottomSheetMixin on StatelessWidget {
  Future<T> show<T>(context) async {
    return await showModalBottomSheet(context: context, builder: (_) => this);
  }
}
