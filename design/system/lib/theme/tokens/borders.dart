import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Borders implements ThemeComponent<Borders> {
  final BorderRadiusGeometry tiny;
  final BorderRadiusGeometry small;
  final BorderRadiusGeometry medium;
  final BorderRadiusGeometry large;
  final double borderWidth;
  final double activeBorderWidth;

  const Borders({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.borderWidth,
    required this.activeBorderWidth,
  });

  @override
  Borders copyWith({
    BorderRadiusGeometry? tiny,
    BorderRadiusGeometry? small,
    BorderRadiusGeometry? medium,
    BorderRadiusGeometry? large,
    double? borderWidth,
    double? activeBorderWidth,
  }) =>
      Borders(
        tiny: tiny ?? this.tiny,
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
        borderWidth: borderWidth ?? this.borderWidth,
        activeBorderWidth: activeBorderWidth ?? this.activeBorderWidth,
      );

  @override
  Borders lerp(Borders? other, double t) {
    if (other is! Borders) return this;
    return Borders(
      tiny: BorderRadiusGeometry.lerp(tiny, other.tiny, t)!,
      small: BorderRadiusGeometry.lerp(small, other.small, t)!,
      medium: BorderRadiusGeometry.lerp(medium, other.medium, t)!,
      large: BorderRadiusGeometry.lerp(large, other.large, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      activeBorderWidth: lerpDouble(activeBorderWidth, other.activeBorderWidth, t)!,
    );
  }
}
