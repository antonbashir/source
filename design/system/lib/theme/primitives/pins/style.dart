import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ProgressPinStyle implements ThemeComponent<ProgressPinStyle> {
  final bool showShadow;
  final double shadowElevation;
  final Color pinColor;
  final Color pinBorderColor;
  final Color thumbColor;
  final Color shadowColor;
  final Color textColor;

  const ProgressPinStyle({
    required this.shadowElevation,
    required this.showShadow,
    required this.pinColor,
    required this.pinBorderColor,
    required this.thumbColor,
    required this.shadowColor,
    required this.textColor,
  });

  @override
  ProgressPinStyle copyWith({
    double? shadowElevation,
    bool? showShadow,
    Color? pinColor,
    Color? pinBorderColor,
    Color? thumbColor,
    Color? shadowColor,
    Color? contentColor,
  }) =>
      ProgressPinStyle(
        shadowElevation: shadowElevation ?? this.shadowElevation,
        showShadow: showShadow ?? this.showShadow,
        pinColor: pinColor ?? this.pinColor,
        pinBorderColor: pinBorderColor ?? this.pinBorderColor,
        thumbColor: thumbColor ?? this.thumbColor,
        shadowColor: shadowColor ?? this.shadowColor,
        textColor: contentColor ?? this.textColor,
      );

  @override
  ProgressPinStyle lerp(ProgressPinStyle? other, double t) {
    if (other is! ProgressPinStyle) return this;
    return ProgressPinStyle(
      shadowElevation: lerpDouble(shadowElevation, other.shadowElevation, t)!,
      showShadow: other.showShadow,
      pinColor: Color.lerp(pinColor, other.pinColor, t)!,
      pinBorderColor: Color.lerp(pinBorderColor, other.pinBorderColor, t)!,
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
