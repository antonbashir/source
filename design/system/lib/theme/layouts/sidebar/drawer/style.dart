import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DrawerStyle implements ThemeComponent<DrawerStyle> {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final Color barrierColor;
  final List<BoxShadow> shadows;

  const DrawerStyle({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.barrierColor,
    required this.shadows,
  });

  @override
  DrawerStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? barrierColor,
    List<BoxShadow>? shadows,
  }) =>
      DrawerStyle(
        textColor: contentColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        barrierColor: barrierColor ?? this.barrierColor,
        shadows: shadows ?? this.shadows,
      );

  @override
  DrawerStyle lerp(ThemeComponent<DrawerStyle>? other, double t) {
    if (other is! DrawerStyle) return this;
    return DrawerStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
    );
  }
}
