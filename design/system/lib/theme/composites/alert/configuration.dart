import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class AlertConfiguration implements ThemeComponent<AlertConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double horizontalGap;
  final double minimumHeight;
  final double verticalGap;
  final EdgeInsetsGeometry padding;
  final TextStyle contentTextStyle;
  final TextStyle labelTextStyle;

  const AlertConfiguration({
    required this.borderRadius,
    required this.horizontalGap,
    required this.minimumHeight,
    required this.verticalGap,
    required this.padding,
    required this.contentTextStyle,
    required this.labelTextStyle,
  });

  @override
  AlertConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? horizontalGap,
    double? minimumHeight,
    double? verticalGap,
    EdgeInsetsGeometry? padding,
    TextStyle? contentTextStyle,
    TextStyle? labelTextStyle,
  }) =>
      AlertConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        horizontalGap: horizontalGap ?? this.horizontalGap,
        minimumHeight: minimumHeight ?? this.minimumHeight,
        verticalGap: verticalGap ?? this.verticalGap,
        padding: padding ?? this.padding,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      );

  @override
  AlertConfiguration lerp(ThemeComponent<AlertConfiguration>? other, double t) {
    if (other is! AlertConfiguration) return this;
    return AlertConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
    );
  }
}
