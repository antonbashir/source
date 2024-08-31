import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class TagStyle implements ThemeComponent<TagStyle> {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;

  const TagStyle({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  TagStyle copyWith({
    Color? contentColor,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return TagStyle(
      textColor: contentColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  TagStyle lerp(TagStyle? other, double t) {
    if (other is! TagStyle) return this;
    return TagStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
