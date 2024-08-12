import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/google-icon.svg',
      width: 18,
      colorFilter:
          ColorFilter.mode(MyselffTheme.colorOnPrimary, BlendMode.srcIn),
    );
  }
}
