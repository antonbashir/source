import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class SwitchStyle implements ThemeComponent<SwitchStyle> {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color thumbIconColor;
  final Color thumbColor;
  final List<BoxShadow> thumbShadows;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const SwitchStyle({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.thumbIconColor,
    required this.thumbColor,
    required this.thumbShadows,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  SwitchStyle copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Color? thumbIconColor,
    Color? thumbColor,
    List<BoxShadow>? thumbShadows,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      SwitchStyle(
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
        activeTrackColor: activeTrackColor ?? this.activeTrackColor,
        inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
        activeTextColor: activeTextColor ?? this.activeTextColor,
        inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
        activeIconColor: activeIconColor ?? this.activeIconColor,
        inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
        thumbIconColor: thumbIconColor ?? this.thumbIconColor,
        thumbColor: thumbColor ?? this.thumbColor,
        thumbShadows: thumbShadows ?? this.thumbShadows,
      );

  @override
  SwitchStyle lerp(SwitchStyle? other, double t) {
    if (other is! SwitchStyle) return this;
    return SwitchStyle(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t)!,
      inactiveTrackColor: Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      inactiveTextColor: Color.lerp(inactiveTextColor, other.inactiveTextColor, t)!,
      activeIconColor: Color.lerp(activeIconColor, other.activeIconColor, t)!,
      inactiveIconColor: Color.lerp(inactiveIconColor, other.inactiveIconColor, t)!,
      thumbIconColor: Color.lerp(thumbIconColor, other.thumbIconColor, t)!,
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t)!,
      thumbShadows: BoxShadow.lerpList(thumbShadows, other.thumbShadows, t)!,
    );
  }
}
