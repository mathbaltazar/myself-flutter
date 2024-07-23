import 'package:flutter/material.dart';

class StatefulComponent extends StatefulWidget {
  const StatefulComponent({super.key, required this.builder});

  final Function(BuildContext context, void Function()) builder;

  @override
  State<StatefulComponent> createState() => _StatefulComponentState();
}

class _StatefulComponentState extends State<StatefulComponent> {
  @override
  Widget build(BuildContext context) => widget.builder(context, refresh);

  void refresh() => setState(() {});
}
