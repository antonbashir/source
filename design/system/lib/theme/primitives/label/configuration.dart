import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LabelConfiguration implements ThemeComponent<LabelConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double verticalGap;
  final double minimumHeight;
  final EdgeInsetsGeometry padding;
  final TextStyle labelTextStyle;
  final TextStyle contentTextStyle;

  const LabelConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.verticalGap,
    required this.minimumHeight,
    required this.padding,
    required this.labelTextStyle,
    required this.contentTextStyle,
  });

  @override
  LabelConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? verticalGap,
    double? minimumHeight,
    double? minTouchTargetSize,
    EdgeInsetsGeometry? padding,
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
  }) =>
      LabelConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        verticalGap: verticalGap ?? this.verticalGap,
        minimumHeight: minimumHeight ?? this.minimumHeight,
        padding: padding ?? this.padding,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      );

  @override
  LabelConfiguration lerp(ThemeComponent<LabelConfiguration>? other, double t) {
    if (other is! LabelConfiguration) return this;
    return LabelConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
    );
  }
}
