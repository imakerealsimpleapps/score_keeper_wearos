import 'package:flutter/material.dart';

enum RoundButtonShape {
  circle,
  rectangle,
}

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      this.onPressed,
      this.onLongPressed,
      this.child,
      this.color = Colors.blue,
      this.shape = RoundButtonShape.circle});

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? child;
  final Color? color;
  final RoundButtonShape? shape;

  @override
  Widget build(BuildContext context) {
    double height = 50;
    double radius = 100;
    if (shape == RoundButtonShape.rectangle) {
      height = 30;
      radius = 50;
    }
    return GestureDetector(
      onTap: onPressed,
      onDoubleTap: onLongPressed,
      onForcePressEnd: (details) => onLongPressed,
      child: Container(
        width: 50,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
