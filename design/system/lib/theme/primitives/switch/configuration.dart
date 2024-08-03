import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class SwitchConfiguration implements ThemeComponent<SwitchConfiguration> {
  final double height;
  final double width;
  final double thumbSizeValue;
  final double iconSizeValue;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  const SwitchConfiguration({
    required this.height,
    required this.width,
    required this.thumbSizeValue,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  SwitchConfiguration copyWith({
    double? height,
    double? width,
    double? thumbSizeValue,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) =>
      SwitchConfiguration(
        height: height ?? this.height,
        width: width ?? this.width,
        thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        padding: padding ?? this.padding,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  SwitchConfiguration lerp(SwitchConfiguration? other, double t) {
    if (other is! SwitchConfiguration) return this;
    return SwitchConfiguration(
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
