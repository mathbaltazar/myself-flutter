import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

class CircularProgressIcon extends StatelessWidget {
  const CircularProgressIcon({
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;
  
  static const double _defaultSize = 18;
  static final Color _defaultColor = MyselffTheme.colorOnPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size ?? _defaultSize,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(color ?? _defaultColor),
      ),
    );
  }
}
