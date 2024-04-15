import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DrawerConfiguration implements ThemeComponent<DrawerConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double width;
  final TextStyle textStyle;

  const DrawerConfiguration({
    required this.borderRadius,
    required this.width,
    required this.textStyle,
  });

  @override
  DrawerConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? width,
    TextStyle? textStyle,
  }) =>
      DrawerConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  DrawerConfiguration lerp(ThemeComponent<DrawerConfiguration>? other, double t) {
    if (other is! DrawerConfiguration) return this;
    return DrawerConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      width: lerpDouble(width, other.width, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
