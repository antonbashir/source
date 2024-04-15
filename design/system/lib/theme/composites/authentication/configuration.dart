import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class AuthenticationCodeConfiguration implements ThemeComponent<AuthenticationCodeConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double gap;
  final double height;
  final double width;
  final TextStyle textStyle;
  final TextStyle errorTextStyle;

  const AuthenticationCodeConfiguration({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.width,
    required this.textStyle,
    required this.errorTextStyle,
  });

  @override
  AuthenticationCodeConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? width,
    TextStyle? textStyle,
    TextStyle? errorTextStyle,
  }) {
    return AuthenticationCodeConfiguration(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      height: height ?? this.height,
      width: width ?? this.width,
      textStyle: textStyle ?? this.textStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
    );
  }

  @override
  AuthenticationCodeConfiguration lerp(ThemeComponent<AuthenticationCodeConfiguration>? other, double t) {
    if (other is! AuthenticationCodeConfiguration) return this;
    return AuthenticationCodeConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t)!,
    );
  }
}
