import 'package:flutter/widgets.dart';

@immutable
class AvatarStyle {
  final Color backgroundColor;
  final Color badgeColor;
  final Color iconColor;
  final Color textColor;

  const AvatarStyle({
    required this.backgroundColor,
    required this.badgeColor,
    required this.iconColor,
    required this.textColor,
  });

  AvatarStyle copyWith({
    Color? backgroundColor,
    Color? badgeColor,
    Color? iconColor,
    Color? textColor,
  }) =>
      AvatarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        badgeColor: badgeColor ?? this.badgeColor,
        iconColor: iconColor ?? this.iconColor,
        textColor: textColor ?? this.textColor,
      );

  AvatarStyle lerp(AvatarStyle? other, double t) {
    if (other is! AvatarStyle) return this;
    return AvatarStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      badgeColor: Color.lerp(badgeColor, other.badgeColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
