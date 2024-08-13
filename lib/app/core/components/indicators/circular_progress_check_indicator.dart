import 'package:flutter/material.dart';


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
                backgroundColor: Colors.black26,
              ),
        ),
        Icon(
          Icons.check_circle,
          size: 36,
          color: progressValue == 1
              ? Theme.of(context).colorScheme.primary
              : Colors.black54,
        ),
      ],
    );
  }
}
