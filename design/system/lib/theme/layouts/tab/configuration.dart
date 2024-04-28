import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class TabBarConfiguration implements ThemeComponent<TabBarConfiguration> {
  final double gap;
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double height;
  final double iconSizeValue;
  final double indicatorHeight;
  final double tabGap;
  final EdgeInsetsGeometry tabPadding;
  final TextStyle textStyle;
  final double minTouchTargetSize;

  const TabBarConfiguration({
    required this.gap,
    required this.borderType,
    required this.borderRadius,
    required this.height,
    required this.iconSizeValue,
    required this.indicatorHeight,
    required this.tabGap,
    required this.tabPadding,
    required this.textStyle,
    required this.minTouchTargetSize,
  });

  @override
  TabBarConfiguration copyWith({
    double? gap,
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? height,
    double? iconSizeValue,
    double? indicatorHeight,
    double? tabGap,
    EdgeInsetsGeometry? tabPadding,
    TextStyle? textStyle,
    double? minTouchTargetSize,
  }) =>
      TabBarConfiguration(
        gap: gap ?? this.gap,
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        height: height ?? this.height,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        indicatorHeight: indicatorHeight ?? this.indicatorHeight,
        tabGap: tabGap ?? this.tabGap,
        tabPadding: tabPadding ?? this.tabPadding,
        textStyle: textStyle ?? this.textStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      );

  @override
  TabBarConfiguration lerp(ThemeComponent<TabBarConfiguration>? other, double t) {
    if (other is! TabBarConfiguration) return this;
    return TabBarConfiguration(
      borderType: other.borderType,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      indicatorHeight: lerpDouble(indicatorHeight, other.indicatorHeight, t)!,
      tabGap: lerpDouble(tabGap, other.tabGap, t)!,
      tabPadding: EdgeInsetsGeometry.lerp(tabPadding, other.tabPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
    );
  }
}
