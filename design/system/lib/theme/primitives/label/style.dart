import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LabelStyle implements ThemeComponent<LabelStyle> {
  final Color backgroundColor;
  final Color iconColor;
  final Color labelTextColor;
  final Color contentTextColor;

  const LabelStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.labelTextColor,
    required this.contentTextColor,
  });

  @override
  LabelStyle copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? iconColor,
    Color? labelTextColor,
    Color? contentTextColor,
  }) =>
      LabelStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        iconColor: iconColor ?? this.iconColor,
        labelTextColor: labelTextColor ?? this.labelTextColor,
        contentTextColor: contentTextColor ?? this.contentTextColor,
      );

  @override
  LabelStyle lerp(ThemeComponent<LabelStyle>? other, double t) {
    if (other is! LabelStyle) return this;
    return LabelStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t)!,
      contentTextColor: Color.lerp(contentTextColor, other.contentTextColor, t)!,
    );
  }
}
