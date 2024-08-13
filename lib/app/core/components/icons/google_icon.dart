import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myselff_flutter/app/core/extensions/object_extensions.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({
    super.key,
    this.color,
  });

  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/google-icon.svg',
      width: 18,
      colorFilter: _getColor(context)?.let((it) => ColorFilter.mode(it, BlendMode.srcIn)),
    );
  }
  
  Color? _getColor(BuildContext context) {
    return color ?? Theme.of(context).colorScheme.onPrimary;  
  }
}
