import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TabBarStyle implements ThemeComponent<TabBarStyle> {
  final Color indicatorColor;
  final Color segmentTextColor;
  final Color selectedSegmentTextColor;
  final Color selectedPillTextColor;
  final Color selectedPillTabColor;
  final Duration animationDuration;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const TabBarStyle({
    required this.indicatorColor,
    required this.segmentTextColor,
    required this.selectedSegmentTextColor,
    required this.selectedPillTextColor,
    required this.selectedPillTabColor,
    required this.animationDuration,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  TabBarStyle copyWith({
    Color? indicatorColor,
    Color? contentColor,
    Color? selectedSegmentTextColor,
    Color? selectedPillTextColor,
    Color? selectedPillTabColor,
    Duration? animationDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      TabBarStyle(
        indicatorColor: indicatorColor ?? this.indicatorColor,
        segmentTextColor: contentColor ?? this.segmentTextColor,
        selectedSegmentTextColor: selectedSegmentTextColor ?? this.selectedSegmentTextColor,
        selectedPillTextColor: selectedPillTextColor ?? this.selectedPillTextColor,
        selectedPillTabColor: selectedPillTabColor ?? this.selectedPillTabColor,
        animationDuration: animationDuration ?? this.animationDuration,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  TabBarStyle lerp(ThemeComponent<TabBarStyle>? other, double t) {
    if (other is! TabBarStyle) return this;
    return TabBarStyle(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t)!,
      segmentTextColor: Color.lerp(segmentTextColor, other.segmentTextColor, t)!,
      selectedSegmentTextColor: Color.lerp(selectedSegmentTextColor, other.selectedSegmentTextColor, t)!,
      selectedPillTextColor: Color.lerp(selectedPillTextColor, other.selectedPillTextColor, t)!,
      selectedPillTabColor: Color.lerp(selectedPillTabColor, other.selectedPillTabColor, t)!,
      animationDuration: lerpDuration(animationDuration, other.animationDuration, t),
    );
  }
}
