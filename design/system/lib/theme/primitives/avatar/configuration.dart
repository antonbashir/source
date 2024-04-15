import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class AvatarConfiguration with Interpolatable<AvatarConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double avatarSizeValue;
  final double badgeMarginValue;
  final double badgeSizeValue;
  final TextStyle textStyle;

  const AvatarConfiguration({
    required this.avatarSizeValue,
    required this.badgeSizeValue,
    required this.badgeMarginValue,
    required this.borderRadius,
    required this.textStyle,
  });

  AvatarConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? avatarSizeValue,
    double? badgeMarginValue,
    double? badgeSizeValue,
    TextStyle? textStyle,
  }) {
    return AvatarConfiguration(
      borderRadius: borderRadius ?? this.borderRadius,
      avatarSizeValue: avatarSizeValue ?? this.avatarSizeValue,
      badgeMarginValue: badgeMarginValue ?? this.badgeMarginValue,
      badgeSizeValue: badgeSizeValue ?? this.badgeSizeValue,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  AvatarConfiguration lerp(AvatarConfiguration? other, double t) {
    if (other is! AvatarConfiguration) return this;
    return AvatarConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      avatarSizeValue: lerpDouble(avatarSizeValue, other.avatarSizeValue, t)!,
      badgeMarginValue: lerpDouble(badgeMarginValue, other.badgeMarginValue, t)!,
      badgeSizeValue: lerpDouble(badgeSizeValue, other.badgeSizeValue, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
