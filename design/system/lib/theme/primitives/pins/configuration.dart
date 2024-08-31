import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ProgressPinConfiguration implements ThemeComponent<ProgressPinConfiguration> {
  final double arrowHeight;
  final double arrowWidth;
  final double pinDistance;
  final double pinWidth;
  final double pinBorderWidth;
  final TextStyle textStyle;

  const ProgressPinConfiguration({
    required this.arrowHeight,
    required this.arrowWidth,
    required this.pinDistance,
    required this.pinWidth,
    required this.pinBorderWidth,
    required this.textStyle,
  });

  @override
  ProgressPinConfiguration copyWith({
    double? arrowHeight,
    double? arrowWidth,
    double? pinDistance,
    double? pinWidth,
    double? pinBorderWidth,
    TextStyle? textStyle,
  }) =>
      ProgressPinConfiguration(
        arrowHeight: arrowHeight ?? this.arrowHeight,
        arrowWidth: arrowWidth ?? this.arrowWidth,
        pinDistance: pinDistance ?? this.pinDistance,
        pinWidth: pinWidth ?? this.pinWidth,
        pinBorderWidth: pinBorderWidth ?? this.pinBorderWidth,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ProgressPinConfiguration lerp(ProgressPinConfiguration? other, double t) {
    if (other is! ProgressPinConfiguration) return this;
    return ProgressPinConfiguration(
      arrowHeight: lerpDouble(arrowHeight, other.arrowHeight, t)!,
      arrowWidth: lerpDouble(arrowWidth, other.arrowWidth, t)!,
      pinDistance: lerpDouble(pinDistance, other.pinDistance, t)!,
      pinWidth: lerpDouble(pinWidth, other.pinWidth, t)!,
      pinBorderWidth: lerpDouble(pinBorderWidth, other.pinBorderWidth, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
