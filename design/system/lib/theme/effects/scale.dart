import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ScaleEffectStyle implements ThemeComponent<ScaleEffectStyle> {
  final Color color;
  final Duration duration;
  final Curve curve;
  final double extent;
  final double upscale;
  final double downscale;

  const ScaleEffectStyle({
    required this.color,
    required this.duration,
    required this.curve,
    required this.extent,
    required this.upscale,
    required this.downscale,
  });

  @override
  ScaleEffectStyle copyWith({
    Color? color,
    Duration? duration,
    Curve? curve,
    double? extent,
    double? upscale,
    double? downscale,
  }) =>
      ScaleEffectStyle(
        color: color ?? this.color,
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
        extent: extent ?? this.extent,
        upscale: upscale ?? this.upscale,
        downscale: downscale ?? this.downscale,
      );

  @override
  ScaleEffectStyle lerp(ScaleEffectStyle? other, double t) {
    if (other is! ScaleEffectStyle) return this;
    return ScaleEffectStyle(
      color: Color.lerp(color, other.color, t)!,
      duration: lerpDuration(duration, other.duration, t),
      curve: other.curve,
      extent: lerpDouble(extent, other.extent, t)!,
      upscale: lerpDouble(upscale, other.upscale, t)!,
      downscale: lerpDouble(downscale, other.downscale, t)!,
    );
  }
}
