import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class RadioConfiguration implements ThemeComponent<RadioConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double tapAreaSizeValue;
  final double innerRadius;
  final double outerRadius;
  final double size;

  const RadioConfiguration({
    required this.tapAreaSizeValue,
    required this.innerRadius,
    required this.outerRadius,
    required this.borderRadius,
    required this.size,
  });

  @override
  RadioConfiguration copyWith({
    double? tapAreaSizeValue,
    double? innerRadius,
    double? outerRadius,
    double? size,
    BorderRadiusGeometry? borderRadius,
  }) =>
      RadioConfiguration(
        tapAreaSizeValue: tapAreaSizeValue ?? this.tapAreaSizeValue,
        innerRadius: innerRadius ?? this.innerRadius,
        outerRadius: outerRadius ?? this.outerRadius,
        size: size ?? this.size,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  @override
  RadioConfiguration lerp(RadioConfiguration? other, double t) {
    if (other is! RadioConfiguration) return this;
    return RadioConfiguration(
      tapAreaSizeValue: lerpDouble(tapAreaSizeValue, other.tapAreaSizeValue, t)!,
      innerRadius: lerpDouble(innerRadius, other.innerRadius, t)!,
      outerRadius: lerpDouble(outerRadius, other.outerRadius, t)!,
      size: lerpDouble(size, other.size, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
    );
  }
}
