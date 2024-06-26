import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class PulseEffectStyle implements ThemeComponent<PulseEffectStyle> {
  final Color color;
  final Duration duration;
  final Curve curve;
  final double extent;

  const PulseEffectStyle({
    required this.color,
    required this.duration,
    required this.curve,
    required this.extent,
  });

  @override
  PulseEffectStyle copyWith({
    Color? color,
    Duration? duration,
    Curve? curve,
    double? extent,
  }) =>
      PulseEffectStyle(
        color: color ?? this.color,
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
        extent: extent ?? this.extent,
      );

  @override
  PulseEffectStyle lerp(PulseEffectStyle? other, double t) {
    if (other is! PulseEffectStyle) return this;
    return PulseEffectStyle(
      color: Color.lerp(color, other.color, t)!,
      duration: lerpDuration(duration, other.duration, t),
      curve: other.curve,
      extent: lerpDouble(extent, other.extent, t)!,
    );
  }
}
