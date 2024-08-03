import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class FocusEffectStyle implements ThemeComponent<FocusEffectStyle> {
  final Color color;
  final double extent;
  final Duration duration;
  final Curve curve;

  const FocusEffectStyle({
    required this.color,
    required this.extent,
    required this.duration,
    required this.curve,
  });

  @override
  FocusEffectStyle copyWith({
    Color? color,
    double? extent,
    Duration? duration,
    Curve? curve,
  }) =>
      FocusEffectStyle(
        color: color ?? this.color,
        extent: extent ?? this.extent,
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
      );

  @override
  FocusEffectStyle lerp(FocusEffectStyle? other, double t) {
    if (other is! FocusEffectStyle) return this;
    return FocusEffectStyle(
      color: Color.lerp(color, other.color, t)!,
      extent: lerpDouble(extent, other.extent, t)!,
      duration: lerpDuration(duration, other.duration, t),
      curve: other.curve,
    );
  }
}
