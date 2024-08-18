import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class HoverEffectStyle implements ThemeComponent<HoverEffectStyle> {
  final Color color;
  final Duration duration;
  final Curve curve;

  const HoverEffectStyle({
    required this.color,
    required this.duration,
    required this.curve,
  });

  @override
  HoverEffectStyle copyWith({
    Color? color,
    Duration? duration,
    Curve? curve,
  }) =>
      HoverEffectStyle(
        color: color ?? this.color,
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
      );

  @override
  HoverEffectStyle lerp(HoverEffectStyle? other, double t) {
    if (other is! HoverEffectStyle) return this;
    return HoverEffectStyle(
      color: Color.lerp(color, other.color, t)!,
      duration: lerpDuration(duration, other.duration, t),
      curve: other.curve,
    );
  }
}
