import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      this.onPressed,
      this.onLongPressed,
      this.child,
      this.color = Colors.blue});

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onDoubleTap: onLongPressed,
      onForcePressEnd: (details) => onLongPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
