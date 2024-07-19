import 'dart:ui';

import 'package:flutter/widgets.dart';

@immutable
class ScrollbarConfiguration {
  final WidgetStateProperty<double?> thickness;
  final WidgetStateProperty<double?> thicknessWithTrack;
  final Radius radius;
  final double crossAxisMargin;
  final double mainAxisMargin;
  final double minThumbLength;

  const ScrollbarConfiguration({
    required this.thickness,
    required this.thicknessWithTrack,
    required this.minThumbLength,
    required this.radius,
    required this.crossAxisMargin,
    required this.mainAxisMargin,
  });

  ScrollbarConfiguration copyWith({
    WidgetStateProperty<double?>? thickness,
    WidgetStateProperty<double?>? thicknessWithTrack,
    Radius? radius,
    double? crossAxisMargin,
    double? mainAxisMargin,
    double? minThumbLength,
    EdgeInsets? childPadding,
  }) =>
      ScrollbarConfiguration(
        thickness: thickness ?? this.thickness,
        thicknessWithTrack: thicknessWithTrack ?? this.thicknessWithTrack,
        radius: radius ?? this.radius,
        crossAxisMargin: crossAxisMargin ?? this.crossAxisMargin,
        mainAxisMargin: mainAxisMargin ?? this.mainAxisMargin,
        minThumbLength: minThumbLength ?? this.minThumbLength,
      );

  ScrollbarConfiguration lerp(ScrollbarConfiguration? other, double t) {
    if (other is! ScrollbarConfiguration) return this;
    return ScrollbarConfiguration(
      thickness: WidgetStateProperty.lerp<double?>(thickness, other.thickness, t, lerpDouble)!,
      thicknessWithTrack: WidgetStateProperty.lerp<double?>(thicknessWithTrack, other.thicknessWithTrack, t, lerpDouble)!,
      radius: Radius.lerp(radius, other.radius, t)!,
      crossAxisMargin: lerpDouble(crossAxisMargin, other.crossAxisMargin, t)!,
      mainAxisMargin: lerpDouble(mainAxisMargin, other.mainAxisMargin, t)!,
      minThumbLength: lerpDouble(minThumbLength, other.minThumbLength, t)!,
    );
  }
}
