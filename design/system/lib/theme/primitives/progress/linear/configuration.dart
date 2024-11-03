import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LinearProgressConfiguration implements ThemeComponent<LinearProgressConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double progressHeight;
  final double thumbSizeValue;
  final double verticalGap;
  final TextStyle textStyle;

  const LinearProgressConfiguration({
    required this.borderRadius,
    required this.progressHeight,
    required this.thumbSizeValue,
    required this.verticalGap,
    required this.textStyle,
  });

  @override
  LinearProgressConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? progressHeight,
    double? thumbSizeValue,
    double? verticalGap,
    TextStyle? textStyle,
  }) =>
      LinearProgressConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        progressHeight: progressHeight ?? this.progressHeight,
        thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
        verticalGap: verticalGap ?? this.verticalGap,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  LinearProgressConfiguration lerp(LinearProgressConfiguration? other, double t) {
    if (other is! LinearProgressConfiguration) return this;
    return LinearProgressConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
