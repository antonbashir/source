import 'package:design/constants/mathematic.dart';
import 'package:design/model/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ScrollbarStyle {
  final VisualStateProperty<bool?> thumbVisibility;
  final VisualStateProperty<bool?> trackVisibility;
  final VisualStateProperty<Color?> thumbColor;
  final VisualStateProperty<Color?> trackColor;
  final VisualStateProperty<Color?> trackBorderColor;
  final bool interactive;
  final Duration fadeDuration;
  final Duration timeToFade;
  final Duration hoverDuration;

  const ScrollbarStyle({
    required this.thumbColor,
    required this.trackColor,
    required this.trackBorderColor,
    required this.interactive,
    required this.fadeDuration,
    required this.timeToFade,
    required this.hoverDuration,
    required this.thumbVisibility,
    required this.trackVisibility,
  });

  ScrollbarStyle copyWith({
    bool? interactive,
    VisualStateProperty<bool?>? thumbVisibility,
    VisualStateProperty<bool?>? trackVisibility,
    VisualStateProperty<Color?>? thumbColor,
    VisualStateProperty<Color?>? trackColor,
    VisualStateProperty<Color?>? trackBorderColor,
    Duration? fadeDuration,
    Duration? timeToFade,
    Duration? hoverDuration,
  }) {
    return ScrollbarStyle(
      interactive: interactive ?? this.interactive,
      thumbColor: thumbColor ?? this.thumbColor,
      trackColor: trackColor ?? this.trackColor,
      trackBorderColor: trackBorderColor ?? this.trackBorderColor,
      fadeDuration: fadeDuration ?? this.fadeDuration,
      timeToFade: timeToFade ?? this.timeToFade,
      hoverDuration: hoverDuration ?? this.hoverDuration,
      thumbVisibility: thumbVisibility ?? this.thumbVisibility,
      trackVisibility: trackVisibility ?? this.trackVisibility,
    );
  }

  ScrollbarStyle lerp(ScrollbarStyle? other, double t) {
    if (other is! ScrollbarStyle) return this;
    return ScrollbarStyle(
      interactive: lerpBool(interactive, other.interactive, t)!,
      thumbColor: VisualStateProperty.lerp<Color?>(thumbColor, other.thumbColor, t, Color.lerp)!,
      trackColor: VisualStateProperty.lerp<Color?>(trackColor, other.trackColor, t, Color.lerp)!,
      trackBorderColor: VisualStateProperty.lerp<Color?>(trackBorderColor, other.trackBorderColor, t, Color.lerp)!,
      fadeDuration: lerpDuration(fadeDuration, other.fadeDuration, t),
      timeToFade: lerpDuration(timeToFade, other.timeToFade, t),
      hoverDuration: lerpDuration(hoverDuration, other.hoverDuration, t),
      thumbVisibility: VisualStateProperty.lerp<bool?>(thumbVisibility, other.thumbVisibility, t, lerpBool)!,
      trackVisibility: VisualStateProperty.lerp<bool?>(trackVisibility, other.trackVisibility, t, lerpBool)!,
    );
  }
}
