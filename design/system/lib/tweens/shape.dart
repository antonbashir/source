import 'package:flutter/widgets.dart';

class ShapeBorderTween extends Tween<ShapeBorder?> {
  ShapeBorderTween({super.begin, super.end});

  @override
  ShapeBorder? lerp(double t) => ShapeBorder.lerp(begin, end, t);
}
