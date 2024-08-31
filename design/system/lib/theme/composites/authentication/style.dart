import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class AuthenticationCodeStyle implements ThemeComponent<AuthenticationCodeStyle> {
  final Color selectedBorderColor;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color errorBorderColor;
  final Color selectedFillColor;
  final Color activeFillColor;
  final Color inactiveFillColor;
  final Color textColor;
  final Duration animationDuration;
  final Duration errorAnimationDuration;
  final Duration peekDuration;
  final Curve animationCurve;
  final Curve errorAnimationCurve;

  const AuthenticationCodeStyle({
    required this.selectedBorderColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.selectedFillColor,
    required this.activeFillColor,
    required this.inactiveFillColor,
    required this.textColor,
    required this.animationDuration,
    required this.errorAnimationDuration,
    required this.peekDuration,
    required this.animationCurve,
    required this.errorAnimationCurve,
  });

  @override
  AuthenticationCodeStyle copyWith({
    Color? selectedBorderColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? selectedFillColor,
    Color? activeFillColor,
    Color? inactiveFillColor,
    Color? contentColor,
    Duration? animationDuration,
    Duration? errorAnimationDuration,
    Duration? peekDuration,
    Curve? animationCurve,
    Curve? errorAnimationCurve,
  }) =>
      AuthenticationCodeStyle(
        selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
        activeBorderColor: activeBorderColor ?? this.activeBorderColor,
        inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
        errorBorderColor: errorBorderColor ?? this.errorBorderColor,
        selectedFillColor: selectedFillColor ?? this.selectedFillColor,
        activeFillColor: activeFillColor ?? this.activeFillColor,
        inactiveFillColor: inactiveFillColor ?? this.inactiveFillColor,
        textColor: contentColor ?? this.textColor,
        animationDuration: animationDuration ?? this.animationDuration,
        errorAnimationDuration: errorAnimationDuration ?? this.errorAnimationDuration,
        peekDuration: peekDuration ?? this.peekDuration,
        animationCurve: animationCurve ?? this.animationCurve,
        errorAnimationCurve: errorAnimationCurve ?? this.errorAnimationCurve,
      );

  @override
  AuthenticationCodeStyle lerp(ThemeComponent<AuthenticationCodeStyle>? other, double t) {
    if (other is! AuthenticationCodeStyle) return this;
    return AuthenticationCodeStyle(
      selectedBorderColor: Color.lerp(selectedBorderColor, other.selectedBorderColor, t)!,
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      selectedFillColor: Color.lerp(selectedFillColor, other.selectedFillColor, t)!,
      activeFillColor: Color.lerp(activeFillColor, other.activeFillColor, t)!,
      inactiveFillColor: Color.lerp(inactiveFillColor, other.inactiveFillColor, t)!,
      animationDuration: lerpDuration(animationDuration, other.animationDuration, t),
      errorAnimationDuration: lerpDuration(errorAnimationDuration, other.errorAnimationDuration, t),
      peekDuration: lerpDuration(peekDuration, other.peekDuration, t),
      animationCurve: other.animationCurve,
      errorAnimationCurve: other.errorAnimationCurve,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
