import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ModalStyle implements ThemeComponent<ModalStyle> {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final Color barrierColor;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const ModalStyle({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.barrierColor,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  ModalStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? barrierColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      ModalStyle(
        textColor: contentColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        barrierColor: barrierColor ?? this.barrierColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  ModalStyle lerp(ThemeComponent<ModalStyle>? other, double t) {
    if (other is! ModalStyle) return this;
    return ModalStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
