import 'package:flutter/material.dart';

class CircularProgressIcon extends StatelessWidget {
  const CircularProgressIcon({
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;

  static const double _defaultSize = 18;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size ?? _defaultSize,
      child: CircularProgressIndicator.adaptive(
        valueColor:
            AlwaysStoppedAnimation(color ?? Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
