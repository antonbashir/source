import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class SegmentedControlStyle implements ThemeComponent<SegmentedControlStyle> {
  final Color backgroundColor;
  final Color selectedSegmentColor;
  final Color segmentTextColor;
  final Color selectedSegmentTextColor;
  final Color focusEffectColor;
  final Decoration decoration;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const SegmentedControlStyle({
    required this.backgroundColor,
    required this.selectedSegmentColor,
    required this.segmentTextColor,
    required this.selectedSegmentTextColor,
    required this.focusEffectColor,
    required this.decoration,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  SegmentedControlStyle copyWith({
    Color? backgroundColor,
    Color? selectedSegmentColor,
    Color? segmentTextColor,
    Color? selectedSegmentTextColor,
    Color? focusEffectColor,
    Decoration? decoration,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return SegmentedControlStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedSegmentColor: selectedSegmentColor ?? this.selectedSegmentColor,
      segmentTextColor: segmentTextColor ?? this.segmentTextColor,
      selectedSegmentTextColor: selectedSegmentTextColor ?? this.selectedSegmentTextColor,
      focusEffectColor: focusEffectColor ?? this.focusEffectColor,
      decoration: decoration ?? this.decoration,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  SegmentedControlStyle lerp(SegmentedControlStyle? other, double t) {
    if (other is! SegmentedControlStyle) return this;
    return SegmentedControlStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      selectedSegmentColor: Color.lerp(selectedSegmentColor, other.selectedSegmentColor, t)!,
      segmentTextColor: Color.lerp(segmentTextColor, other.segmentTextColor, t)!,
      selectedSegmentTextColor: Color.lerp(selectedSegmentTextColor, other.selectedSegmentTextColor, t)!,
      focusEffectColor: Color.lerp(focusEffectColor, other.focusEffectColor, t)!,
      decoration: Decoration.lerp(decoration, other.decoration, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
