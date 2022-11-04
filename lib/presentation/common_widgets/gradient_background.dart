import 'package:flutter/material.dart';

import '../../core/utility/responsive/responsive.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
    this.outterColor = Colors.black,
    this.xAlign = 1.5,
    this.yAlign = -0.4,
    this.radius = 2.1,
  }) : super(key: key);
  final Color? outterColor;
  final double? xAlign, yAlign, radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
          gradient: RadialGradient(
        center: Alignment(xAlign!, yAlign!),
        colors: [
          Colors.blue.shade300,
          Colors.white70,
          Colors.blue.shade200,
          outterColor!,
        ],
        stops: const [
          0.2,
          0.6,
          0.8,
          1,
        ],
        radius: radius!,
        // focal: Alignment.bottomCenter,
      )),
    );
  }
}
