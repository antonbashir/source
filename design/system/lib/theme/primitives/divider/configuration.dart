import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class DividerConfiguration implements ThemeComponent<DividerConfiguration> {
  final double width;
  final double thickness;
  final double indent;
  final double endIndent;

  const DividerConfiguration({
    required this.width,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  DividerConfiguration copyWith({
    double? width,
    double? thickness,
    double? indent,
    double? endIndent,
  }) =>
      DividerConfiguration(
        width: width ?? this.width,
        thickness: thickness ?? this.thickness,
        indent: indent ?? this.indent,
        endIndent: endIndent ?? this.endIndent,
      );

  @override
  DividerConfiguration lerp(DividerConfiguration? other, double t) {
    if (other is! DividerConfiguration) return this;
    return DividerConfiguration(
      width: lerpDouble(width, other.width, t)!,
      thickness: lerpDouble(thickness, other.thickness, t)!,
      indent: lerpDouble(indent, other.indent, t)!,
      endIndent: lerpDouble(endIndent, other.endIndent, t)!,
    );
  }
}
