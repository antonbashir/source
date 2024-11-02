import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class PopoverStyle implements ThemeComponent<PopoverStyle> {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final List<BoxShadow> shadows;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const PopoverStyle({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.shadows,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  PopoverStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? borderColor,
    Color? backgroundColor,
    List<BoxShadow>? shadows,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      PopoverStyle(
        textColor: contentColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        borderColor: borderColor ?? this.borderColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        shadows: shadows ?? this.shadows,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  PopoverStyle lerp(ThemeComponent<PopoverStyle>? other, double t) {
    if (other is! PopoverStyle) return this;
    return PopoverStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
