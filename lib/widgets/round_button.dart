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
      this.shape = RoundButtonShape.circle,
      double? height,
      double? width,
      double? radius}): 
      _width = width ?? 50,
      _height = height ?? (shape == RoundButtonShape.rectangle ? 30 : 50),
      _radius = radius ?? (shape == RoundButtonShape.rectangle ? 50 : 100)
      ;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? child;
  final Color? color;
  final RoundButtonShape? shape;
  final double _height;
  final double _width;
  final double _radius;

  @override
  Widget build(BuildContext context) {
    // double height = 50;
    // double radius = 100;
    // if (shape == RoundButtonShape.rectangle) {
    //   height = 30;
    //   radius = 50;
    // }
    return GestureDetector(
      onTap: onPressed,
      onDoubleTap: onLongPressed,
      onForcePressEnd: (details) => onLongPressed,
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
