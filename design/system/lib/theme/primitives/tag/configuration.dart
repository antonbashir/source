import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class TagConfiguration implements ThemeComponent<TagConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double gap;
  final double height;
  final double iconSizeValue;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  const TagConfiguration({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  TagConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    TextStyle? upperCaseTextStyle,
  }) =>
      TagConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        gap: gap ?? this.gap,
        height: height ?? this.height,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        padding: padding ?? this.padding,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  TagConfiguration lerp(TagConfiguration? other, double t) {
    if (other is! TagConfiguration) return this;
    return TagConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
