import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChipConfiguration implements ThemeComponent<ChipConfiguration> {
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final double gap;
  final double height;
  final double iconSizeValue;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double minTouchTargetSize;

  const ChipConfiguration({
    required this.borderWidth,
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
    required this.minTouchTargetSize,
  });

  @override
  ChipConfiguration copyWith({
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    double? minTouchTargetSize,
  }) =>
      ChipConfiguration(
        borderWidth: borderWidth ?? this.borderWidth,
        borderRadius: borderRadius ?? this.borderRadius,
        gap: gap ?? this.gap,
        height: height ?? this.height,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        padding: padding ?? this.padding,
        textStyle: textStyle ?? this.textStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      );

  @override
  ChipConfiguration lerp(ChipConfiguration? other, double t) {
    if (other is! ChipConfiguration) return this;
    return ChipConfiguration(
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
    );
  }
}
