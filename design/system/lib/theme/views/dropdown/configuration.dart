import 'dart:ui';

import 'package:design/constants/borders.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DropdownConfiguration implements ThemeComponent<DropdownConfiguration> {
  final BorderType borderType;
  final BorderRadiusGeometry borderRadius;
  final double distanceToTarget;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry dropdownMargin;
  final TextStyle textStyle;

  const DropdownConfiguration({
    required this.borderType,
    required this.borderRadius,
    required this.distanceToTarget,
    required this.contentPadding,
    required this.dropdownMargin,
    required this.textStyle,
  });

  @override
  DropdownConfiguration copyWith({
    BorderType? borderType,
    BorderRadiusGeometry? borderRadius,
    double? distanceToTarget,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? dropdownMargin,
    TextStyle? textStyle,
  }) =>
      DropdownConfiguration(
        borderType: borderType ?? this.borderType,
        borderRadius: borderRadius ?? this.borderRadius,
        distanceToTarget: distanceToTarget ?? this.distanceToTarget,
        contentPadding: contentPadding ?? this.contentPadding,
        dropdownMargin: dropdownMargin ?? this.dropdownMargin,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  DropdownConfiguration lerp(ThemeComponent<DropdownConfiguration>? other, double t) {
    if (other is! DropdownConfiguration) return this;
    return DropdownConfiguration(
      borderType: other.borderType,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      distanceToTarget: lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      dropdownMargin: EdgeInsetsGeometry.lerp(dropdownMargin, other.dropdownMargin, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
