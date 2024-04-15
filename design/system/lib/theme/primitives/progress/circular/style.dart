import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class CircularProgressStyle implements ThemeComponent<CircularProgressStyle> {
  final Color color;
  final Color backgroundColor;

  const CircularProgressStyle({
    required this.color,
    required this.backgroundColor,
  });

  @override
  CircularProgressStyle copyWith({
    Color? color,
    Color? backgroundColor,
  }) =>
      CircularProgressStyle(
        color: color ?? this.color,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  @override
  CircularProgressStyle lerp(CircularProgressStyle? other, double t) {
    if (other is! CircularProgressStyle) return this;
    return CircularProgressStyle(
      color: Color.lerp(color, other.color, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
