import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class CircularLoaderStyle implements ThemeComponent<CircularLoaderStyle> {
  final Color color;
  final Color backgroundColor;

  const CircularLoaderStyle({
    required this.color,
    required this.backgroundColor,
  });

  @override
  CircularLoaderStyle copyWith({
    Color? color,
    Color? backgroundColor,
  }) =>
      CircularLoaderStyle(
        color: color ?? this.color,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  @override
  CircularLoaderStyle lerp(CircularLoaderStyle? other, double t) {
    if (other is! CircularLoaderStyle) return this;
    return CircularLoaderStyle(
      color: Color.lerp(color, other.color, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
