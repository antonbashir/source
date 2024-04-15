import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextInputConfiguration implements ThemeComponent<TextInputConfiguration> {
  final EdgeInsetsGeometry helperPadding;
  final TextStyle helperTextStyle;
  final BorderRadiusGeometry borderRadius;
  final double height;
  final double width;
  final double gap;
  final double iconSizeValue;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  const TextInputConfiguration({
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.gap,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
    required this.helperPadding,
    required this.helperTextStyle,
  });

  @override
  TextInputConfiguration copyWith({
    EdgeInsetsGeometry? helperPadding,
    TextStyle? helperTextStyle,
    BorderRadiusGeometry? borderRadius,
    double? height,
    double? width,
    double? gap,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) =>
      TextInputConfiguration(
        helperPadding: helperPadding ?? this.helperPadding,
        helperTextStyle: helperTextStyle ?? this.helperTextStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        height: height ?? this.height,
        width: width ?? this.width,
        gap: gap ?? this.gap,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        padding: padding ?? this.padding,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  TextInputConfiguration lerp(TextInputConfiguration? other, double t) {
    if (other is! TextInputConfiguration) return this;
    return TextInputConfiguration(
      helperPadding: EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
