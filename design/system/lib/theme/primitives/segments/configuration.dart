import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class SegmentedControlConfiguration implements ThemeComponent<SegmentedControlConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double gap;
  final EdgeInsetsGeometry padding;
  final double height;
  final double iconSizeValue;
  final TextStyle segmentTextStyle;
  final BorderRadiusGeometry segmentBorderRadius;
  final double segmentGap;
  final EdgeInsetsGeometry segmentPadding;
  final double minTouchTargetSize;

  const SegmentedControlConfiguration({
    required this.borderType,
    required this.segmentBorderRadius,
    required this.segmentGap,
    required this.height,
    required this.iconSizeValue,
    required this.segmentPadding,
    required this.segmentTextStyle,
    required this.borderRadius,
    required this.gap,
    required this.padding,
    required this.minTouchTargetSize,
  });

  @override
  SegmentedControlConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? gap,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? segmentBorderRadius,
    double? segmentGap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? segmentPadding,
    TextStyle? segmentTextStyle,
    double? minTouchTargetSize,
  }) =>
      SegmentedControlConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        gap: gap ?? this.gap,
        padding: padding ?? this.padding,
        segmentBorderRadius: segmentBorderRadius ?? this.segmentBorderRadius,
        segmentGap: segmentGap ?? this.segmentGap,
        height: height ?? this.height,
        iconSizeValue: iconSizeValue ?? this.iconSizeValue,
        segmentPadding: segmentPadding ?? this.segmentPadding,
        segmentTextStyle: segmentTextStyle ?? this.segmentTextStyle,
        minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      );

  @override
  SegmentedControlConfiguration lerp(SegmentedControlConfiguration? other, double t) {
    if (other is! SegmentedControlConfiguration) return this;
    return SegmentedControlConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      segmentBorderRadius: BorderRadiusGeometry.lerp(segmentBorderRadius, other.segmentBorderRadius, t)!,
      segmentGap: lerpDouble(segmentGap, other.segmentGap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      segmentPadding: EdgeInsetsGeometry.lerp(segmentPadding, other.segmentPadding, t)!,
      segmentTextStyle: TextStyle.lerp(segmentTextStyle, other.segmentTextStyle, t)!,
      minTouchTargetSize: lerpDouble(minTouchTargetSize, other.minTouchTargetSize, t)!,
    );
  }
}
