import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CircularProgressCheckIndicator extends StatelessWidget {
  const CircularProgressCheckIndicator({
    super.key,
    required this.progressValue,
  });

  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: progressValue),
          duration: const Duration(milliseconds: 1500),
          builder: (__, value, _) =>
              CircularProgressIndicator(
                value: value,
                strokeCap: StrokeCap.round,
                strokeAlign: 12,
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
        ),
        FaIcon(
          FontAwesomeIcons.listCheck,
          size: 36,
          color: progressValue == 1
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondaryContainer,
        ),
      ],
    );
  }
}
