import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class RadioStyle implements ThemeComponent<RadioStyle> {
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;

  const RadioStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.textColor,
  });

  @override
  RadioStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? contentColor,
  }) =>
      RadioStyle(
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        textColor: contentColor ?? this.textColor,
      );

  @override
  RadioStyle lerp(RadioStyle? other, double t) {
    if (other is! RadioStyle) return this;
    return RadioStyle(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
