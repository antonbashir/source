import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Borders implements ThemeComponent<Borders> {
  final BorderRadiusGeometry tiny;
  final BorderRadiusGeometry small;
  final BorderRadiusGeometry medium;
  final BorderRadiusGeometry large;
  final double inactiveWidth;
  final double activeWidth;
  final BorderType type;

  const Borders({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.inactiveWidth,
    required this.activeWidth,
    required this.type,
  });

  @override
  Borders copyWith({
    BorderRadiusGeometry? tiny,
    BorderRadiusGeometry? small,
    BorderRadiusGeometry? medium,
    BorderRadiusGeometry? large,
    double? borderWidth,
    double? activeBorderWidth,
    BorderType? type,
  }) =>
      Borders(
        tiny: tiny ?? this.tiny,
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
        inactiveWidth: borderWidth ?? this.inactiveWidth,
        activeWidth: activeBorderWidth ?? this.activeWidth,
        type: type ?? this.type,
      );

  @override
  Borders lerp(Borders? other, double t) {
    if (other is! Borders) return this;
    return Borders(
      tiny: BorderRadiusGeometry.lerp(tiny, other.tiny, t)!,
      small: BorderRadiusGeometry.lerp(small, other.small, t)!,
      medium: BorderRadiusGeometry.lerp(medium, other.medium, t)!,
      large: BorderRadiusGeometry.lerp(large, other.large, t)!,
      inactiveWidth: lerpDouble(inactiveWidth, other.inactiveWidth, t)!,
      activeWidth: lerpDouble(activeWidth, other.activeWidth, t)!,
      type: other.type,
    );
  }
}
