import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class ToastConfiguration implements ThemeComponent<ToastConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double horizontalGap;
  final double verticalGap;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle textStyle;

  const ToastConfiguration({
    required this.borderRadius,
    required this.horizontalGap,
    required this.verticalGap,
    required this.contentPadding,
    required this.textStyle,
  });

  @override
  ToastConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? horizontalGap,
    double? verticalGap,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
  }) =>
      ToastConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        horizontalGap: horizontalGap ?? this.horizontalGap,
        verticalGap: verticalGap ?? this.verticalGap,
        contentPadding: contentPadding ?? this.contentPadding,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ToastConfiguration lerp(ThemeComponent<ToastConfiguration>? other, double t) {
    if (other is! ToastConfiguration) return this;
    return ToastConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
