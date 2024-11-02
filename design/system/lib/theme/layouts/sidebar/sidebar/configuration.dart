import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class SidebarConfiguration implements ThemeComponent<SidebarConfiguration> {
  final double width;
  final double gap;
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double iconSizeValue;
  final double tabGap;
  final EdgeInsetsGeometry tabPadding;
  final EdgeInsetsGeometry tabBarPadding;
  final TextStyle textStyle;
  final double minTouchTargetSize;
  final BorderType tabBarBorderType;
  final BorderRadiusGeometry tabBarBorderRadius;

  const SidebarConfiguration({
    required this.width,
    required this.gap,
    required this.borderType,
    required this.borderRadius,
    required this.iconSizeValue,
    required this.tabGap,
    required this.tabPadding,
    required this.tabBarPadding,
    required this.textStyle,
    required this.minTouchTargetSize,
    required this.tabBarBorderType,
    required this.tabBarBorderRadius,
  });

  @override
  SidebarConfiguration copyWith({
    double? width,
    double? gap,
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? iconSizeValue,
    double? tabGap,
    EdgeInsetsGeometry? tabPadding,
    EdgeInsetsGeometry? tabBarPadding,
    TextStyle? textStyle,
    double? minTouchTargetSize,
    BorderType? tabBarBorderType,
    BorderRadiusGeometry? tabBarBorderRadius,
  }) =>
      SidebarConfiguration(
        width: width ?? this.width,
        gap: gap ?? this.gap,
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        tabGap: tabGap ?? this.tabGap,
        tabPadding: tabPadding ?? this.tabPadding,
        tabBarPadding: tabBarPadding ?? this.tabBarPadding,
        textStyle: textStyle ?? this.textStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
        tabBarBorderRadius: tabBarBorderRadius ?? this.tabBarBorderRadius,
        tabBarBorderType: tabBarBorderType ?? this.tabBarBorderType,
      );

  @override
  SidebarConfiguration lerp(ThemeComponent<SidebarConfiguration>? other, double t) {
    if (other is! SidebarConfiguration) return this;
    return SidebarConfiguration(
      borderType: other.borderType,
      width: lerpDouble(width, other.width, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      tabGap: lerpDouble(tabGap, other.tabGap, t)!,
      tabPadding: EdgeInsetsGeometry.lerp(tabPadding, other.tabPadding, t)!,
      tabBarPadding: EdgeInsetsGeometry.lerp(tabBarPadding, other.tabBarPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
      tabBarBorderType: other.tabBarBorderType,
      tabBarBorderRadius: BorderRadiusGeometry.lerp(tabBarBorderRadius, other.tabBarBorderRadius, t)!,
    );
  }
}
