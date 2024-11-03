import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DropdownStyle implements ThemeComponent<DropdownStyle> {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final List<BoxShadow> shadows;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const DropdownStyle({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.shadows,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  DropdownStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? backgroundColor,
    List<BoxShadow>? shadows,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      DropdownStyle(
        textColor: contentColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        shadows: shadows ?? this.shadows,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  DropdownStyle lerp(ThemeComponent<DropdownStyle>? other, double t) {
    if (other is! DropdownStyle) return this;
    return DropdownStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
