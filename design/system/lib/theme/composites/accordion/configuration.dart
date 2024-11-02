import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class AccordionConfiguration implements ThemeComponent<AccordionConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double headerHeight;
  final double iconSizeValue;
  final EdgeInsetsGeometry headerPadding;
  final TextStyle headerTextStyle;
  final TextStyle contentTextStyle;
  final double minTouchTargetSize;
  final BorderType borderType;

  const AccordionConfiguration({
    required this.borderRadius,
    required this.headerHeight,
    required this.iconSizeValue,
    required this.headerPadding,
    required this.headerTextStyle,
    required this.contentTextStyle,
    required this.minTouchTargetSize,
    required this.borderType,
  });

  @override
  AccordionConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? headerHeight,
    double? iconSizeValue,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? headerTextStyle,
    TextStyle? contentTextStyle,
    double? minTouchTargetSize,
    BorderType? borderType,
  }) =>
      AccordionConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        headerHeight: headerHeight ?? this.headerHeight,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        headerPadding: headerPadding ?? this.headerPadding,
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
        borderType: borderType ?? this.borderType,
      );

  @override
  AccordionConfiguration lerp(ThemeComponent<AccordionConfiguration>? other, double t) {
    if (other is! AccordionConfiguration) return this;
    return AccordionConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
      headerPadding: EdgeInsetsGeometry.lerp(headerPadding, other.headerPadding, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
      borderType: other.borderType,
    );
  }
}
