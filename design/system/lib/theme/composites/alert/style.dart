import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class AlertStyle implements ThemeComponent<AlertStyle> {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const AlertStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  AlertStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    Color? contentColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      AlertStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderColor: borderColor ?? this.borderColor,
        iconColor: iconColor ?? this.iconColor,
        textColor: contentColor ?? this.textColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  AlertStyle lerp(ThemeComponent<AlertStyle>? other, double t) {
    if (other is! AlertStyle) return this;
    return AlertStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
