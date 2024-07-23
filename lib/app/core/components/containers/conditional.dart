import 'package:flutter/material.dart';

class Conditional extends StatelessWidget {
  const Conditional(
    predicate, {
    super.key,
    required Widget onCondition,
    required Widget onElse,
  }) : childPredicate = predicate ? onCondition : onElse;

  final Widget childPredicate;

  @override
  Widget build(BuildContext context) => childPredicate;
}
