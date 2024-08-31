import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class PopoverConfiguration implements ThemeComponent<PopoverConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double distanceToTarget;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle textStyle;
  final double margin;

  const PopoverConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.distanceToTarget,
    required this.contentPadding,
    required this.textStyle,
    required this.margin,
  });

  @override
  PopoverConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? distanceToTarget,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
    double? margin,
  }) =>
      PopoverConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        distanceToTarget: distanceToTarget ?? this.distanceToTarget,
        contentPadding: contentPadding ?? this.contentPadding,
        textStyle: textStyle ?? this.textStyle,
        margin: margin ?? this.margin,
      );

  @override
  PopoverConfiguration lerp(ThemeComponent<PopoverConfiguration>? other, double t) {
    if (other is! PopoverConfiguration) return this;
    return PopoverConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      distanceToTarget: lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      margin: lerpDouble(margin, other.margin, t)!,
    );
  }
}
