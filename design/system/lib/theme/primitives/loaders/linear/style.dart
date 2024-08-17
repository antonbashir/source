import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LinearLoaderStyle implements ThemeComponent<LinearLoaderStyle> {
  final Color color;
  final Color backgroundColor;

  const LinearLoaderStyle({
    required this.color,
    required this.backgroundColor,
  });

  @override
  LinearLoaderStyle copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return LinearLoaderStyle(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  LinearLoaderStyle lerp(LinearLoaderStyle? other, double t) {
    if (other is! LinearLoaderStyle) return this;
    return LinearLoaderStyle(
      color: Color.lerp(color, other.color, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
