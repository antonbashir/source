import 'package:design/model/mixins.dart';
import 'package:design/theme/effects/focus.dart';
import 'package:design/theme/effects/pulse.dart';
import 'package:design/theme/effects/scale.dart';
import 'package:design/theme/effects/hover.dart';
import 'package:flutter/foundation.dart';

@immutable
class EffectsTheme implements ThemeComponent<EffectsTheme> {
  final FocusEffectStyle focus;
  final HoverEffectStyle hover;
  final PulseEffectStyle pulse;
  final ScaleEffectStyle scale;

  const EffectsTheme({
    required this.focus,
    required this.hover,
    required this.pulse,
    required this.scale,
  });

  @override
  EffectsTheme copyWith({
    FocusEffectStyle? focus,
    HoverEffectStyle? hover,
    PulseEffectStyle? pulse,
    ScaleEffectStyle? scale,
  }) =>
      EffectsTheme(
        focus: focus ?? this.focus,
        hover: hover ?? this.hover,
        pulse: pulse ?? this.pulse,
        scale: scale ?? this.scale,
      );

  @override
  EffectsTheme lerp(EffectsTheme? other, double t) {
    if (other is! EffectsTheme) return this;
    return EffectsTheme(
      focus: focus.lerp(other.focus, t),
      hover: hover.lerp(other.hover, t),
      scale: scale.lerp(other.scale, t),
      pulse: pulse.lerp(other.pulse, t),
    );
  }
}
