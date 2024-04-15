import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class SidebarConfiguration implements ThemeComponent<SidebarConfiguration> {
  final double width;
  final double gap;
  final BorderRadiusGeometry borderRadius;
  final double iconSizeValue;
  final double tabGap;
  final EdgeInsetsGeometry tabPadding;
  final EdgeInsetsGeometry tabBarPadding;
  final TextStyle textStyle;
  final double minTouchTargetSize;

  const SidebarConfiguration({
    required this.width,
    required this.gap,
    required this.borderRadius,
    required this.iconSizeValue,
    required this.tabGap,
    required this.tabPadding,
    required this.tabBarPadding,
    required this.textStyle,
    required this.minTouchTargetSize,
  });

  @override
  SidebarConfiguration copyWith({
    double? width,
    double? gap,
    BorderRadiusGeometry? borderRadius,
    double? iconSizeValue,
    double? tabGap,
    EdgeInsetsGeometry? tabPadding,
    EdgeInsetsGeometry? tabBarPadding,
    TextStyle? textStyle,
    double? minTouchTargetSize,
  }) =>
      SidebarConfiguration(
        width: width ?? this.width,
        gap: gap ?? this.gap,
        borderRadius: borderRadius ?? this.borderRadius,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        tabGap: tabGap ?? this.tabGap,
        tabPadding: tabPadding ?? this.tabPadding,
        tabBarPadding: tabBarPadding ?? this.tabBarPadding,
        textStyle: textStyle ?? this.textStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      );

  @override
  SidebarConfiguration lerp(ThemeComponent<SidebarConfiguration>? other, double t) {
    if (other is! SidebarConfiguration) return this;
    return SidebarConfiguration(
      width: lerpDouble(width, other.width, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      tabGap: lerpDouble(tabGap, other.tabGap, t)!,
      tabPadding: EdgeInsetsGeometry.lerp(tabPadding, other.tabPadding, t)!,
      tabBarPadding: EdgeInsetsGeometry.lerp(tabBarPadding, other.tabBarPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
    );
  }
}
