import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LinearProgressStyle implements ThemeComponent<LinearProgressStyle> {
  final Color color;
  final Color textColor;
  final Color backgroundColor;

  const LinearProgressStyle({
    required this.color,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  LinearProgressStyle copyWith({
    Color? color,
    Color? contentColor,
    Color? backgroundColor,
  }) =>
      LinearProgressStyle(
        color: color ?? this.color,
        textColor: contentColor ?? this.textColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  @override
  LinearProgressStyle lerp(ThemeComponent<LinearProgressStyle>? other, double t) {
    if (other is! LinearProgressStyle) return this;
    return LinearProgressStyle(
      color: Color.lerp(color, other.color, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
