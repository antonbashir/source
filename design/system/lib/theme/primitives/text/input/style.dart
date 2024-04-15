import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextInputStyle implements ThemeComponent<TextInputStyle> {
  final Color backgroundColor;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color errorColor;
  final Color hoverBorderColor;
  final Color textColor;
  final Color helperTextColor;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const TextInputStyle({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorColor,
    required this.hoverBorderColor,
    required this.textColor,
    required this.helperTextColor,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  TextInputStyle copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? hoverBorderColor,
    Color? contentColor,
    Color? helperTextColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      TextInputStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        activeBorderColor: activeBorderColor ?? this.activeBorderColor,
        inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
        errorColor: errorColor ?? this.errorColor,
        hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
        textColor: contentColor ?? this.textColor,
        helperTextColor: helperTextColor ?? this.helperTextColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  TextInputStyle lerp(TextInputStyle? other, double t) {
    if (other is! TextInputStyle) return this;
    return TextInputStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      hoverBorderColor: Color.lerp(hoverBorderColor, other.hoverBorderColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      helperTextColor: Color.lerp(helperTextColor, other.helperTextColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
