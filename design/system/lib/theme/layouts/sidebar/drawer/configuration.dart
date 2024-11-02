import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DrawerConfiguration implements ThemeComponent<DrawerConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double width;
  final TextStyle textStyle;

  const DrawerConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.width,
    required this.textStyle,
  });

  @override
  DrawerConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? width,
    TextStyle? textStyle,
  }) =>
      DrawerConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  DrawerConfiguration lerp(ThemeComponent<DrawerConfiguration>? other, double t) {
    if (other is! DrawerConfiguration) return this;
    return DrawerConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      width: lerpDouble(width, other.width, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
