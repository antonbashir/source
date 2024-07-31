import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DotsIndicatorStyle implements ThemeComponent<DotsIndicatorStyle> {
  final Color selectedColor;
  final Color unselectedColor;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const DotsIndicatorStyle({
    required this.selectedColor,
    required this.unselectedColor,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  DotsIndicatorStyle copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      DotsIndicatorStyle(
        selectedColor: selectedColor ?? this.selectedColor,
        unselectedColor: unselectedColor ?? this.unselectedColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  DotsIndicatorStyle lerp(DotsIndicatorStyle? other, double t) {
    if (other is! DotsIndicatorStyle) return this;
    return DotsIndicatorStyle(
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
