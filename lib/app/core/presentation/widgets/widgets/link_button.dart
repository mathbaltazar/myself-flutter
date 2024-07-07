import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.onClick,
    required this.label,
    this.fontSize,
    this.decoration,
    this.color,
    this.enabled,
  });

  final Function() onClick;
  final String label;
  final double? fontSize;
  final TextDecoration? decoration;
  final Color? color;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ?? true ? onClick : null,
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize ?? 12,
          decoration: decoration ?? TextDecoration.underline,
          color: enabled ?? true
              ? color ?? MyselffTheme.colorPrimary
              : Colors.black26,
          decorationColor: enabled ?? true
              ? color ?? MyselffTheme.colorPrimary
              : Colors.black26,
        ),
      ),
    );
  }
}
