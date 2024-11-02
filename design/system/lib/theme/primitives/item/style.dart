import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ListItemStyle implements ThemeComponent<ListItemStyle> {
  final Color backgroundColor;
  final Color dividerColor;
  final Color iconColor;
  final Color labelTextColor;
  final Color contentTextColor;

  const ListItemStyle({
    required this.backgroundColor,
    required this.dividerColor,
    required this.iconColor,
    required this.labelTextColor,
    required this.contentTextColor,
  });

  @override
  ListItemStyle copyWith({
    Color? backgroundColor,
    Color? dividerColor,
    Color? iconColor,
    Color? labelTextColor,
    Color? contentTextColor,
  }) =>
      ListItemStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        dividerColor: dividerColor ?? this.dividerColor,
        iconColor: iconColor ?? this.iconColor,
        labelTextColor: labelTextColor ?? this.labelTextColor,
        contentTextColor: contentTextColor ?? this.contentTextColor,
      );

  @override
  ListItemStyle lerp(ThemeComponent<ListItemStyle>? other, double t) {
    if (other is! ListItemStyle) return this;
    return ListItemStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t)!,
      contentTextColor: Color.lerp(contentTextColor, other.contentTextColor, t)!,
    );
  }
}
