import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class CheckboxConfiguration implements ThemeComponent<CheckboxConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;
  final double tapAreaSizeValue;
  final double size;
  final double strokeWidth;

  const CheckboxConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.textStyle,
    required this.tapAreaSizeValue,
    required this.size,
    required this.strokeWidth,
  });

  @override
  CheckboxConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
    double? tapAreaSizeValue,
    double? size,
    double? strokeWidth,
  }) =>
      CheckboxConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        textStyle: textStyle ?? this.textStyle,
        tapAreaSizeValue: tapAreaSizeValue ?? this.tapAreaSizeValue,
        size: size ?? this.size,
        strokeWidth: strokeWidth ?? this.strokeWidth,
      );

  @override
  CheckboxConfiguration lerp(CheckboxConfiguration? other, double t) {
    if (other is! CheckboxConfiguration) return this;
    return CheckboxConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      tapAreaSizeValue: lerpDouble(tapAreaSizeValue, other.tapAreaSizeValue, t)!,
      size: lerpDouble(size, other.size, t)!,
      strokeWidth: lerpDouble(strokeWidth, other.strokeWidth, t)!,
    );
  }
}
