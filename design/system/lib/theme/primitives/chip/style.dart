import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChipStyle implements ThemeComponent<ChipStyle> {
  final Color activeBorderColor;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color contentColor;

  const ChipStyle({
    required this.activeBorderColor,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.contentColor,
  });

  @override
  ChipStyle copyWith({
    Color? activeBorderColor,
    Color? backgroundColor,
    Color? activeBackgroundColor,
    Color? contentColor,
  }) =>
      ChipStyle(
        activeBorderColor: activeBorderColor ?? this.activeBorderColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        activeBackgroundColor: activeBackgroundColor ?? this.activeBackgroundColor,
        contentColor: contentColor ?? this.contentColor,
      );

  @override
  ChipStyle lerp(ChipStyle? other, double t) {
    if (other is! ChipStyle) return this;
    return ChipStyle(
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeBackgroundColor: Color.lerp(activeBackgroundColor, other.activeBackgroundColor, t)!,
      contentColor: Color.lerp(contentColor, other.contentColor, t)!,
    );
  }
}
