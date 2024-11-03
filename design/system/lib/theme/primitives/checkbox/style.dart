import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class CheckboxStyle implements ThemeComponent<CheckboxStyle> {
  final Color activeColor;
  final Color borderColor;
  final Color checkColor;
  final Color inactiveColor;

  const CheckboxStyle({
    required this.activeColor,
    required this.borderColor,
    required this.checkColor,
    required this.inactiveColor,
  });

  @override
  CheckboxStyle copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? inactiveColor,
    Color? contentColor,
  }) =>
      CheckboxStyle(
        activeColor: activeColor ?? this.activeColor,
        borderColor: borderColor ?? this.borderColor,
        checkColor: checkColor ?? this.checkColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
      );

  @override
  CheckboxStyle lerp(CheckboxStyle? other, double t) {
    if (other is! CheckboxStyle) return this;
    return CheckboxStyle(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      checkColor: Color.lerp(checkColor, other.checkColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
    );
  }
}
