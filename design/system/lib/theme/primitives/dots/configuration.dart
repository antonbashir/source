import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DotsIndicatorConfiguration implements ThemeComponent<DotsIndicatorConfiguration> {
  final double gap;
  final double size;

  const DotsIndicatorConfiguration({
    required this.size,
    required this.gap,
  });

  @override
  DotsIndicatorConfiguration copyWith({
    double? gap,
    double? size,
  }) =>
      DotsIndicatorConfiguration(
        gap: gap ?? this.gap,
        size: size ?? this.size,
      );

  @override
  DotsIndicatorConfiguration lerp(DotsIndicatorConfiguration? other, double t) {
    if (other is! DotsIndicatorConfiguration) return this;
    return DotsIndicatorConfiguration(
      gap: lerpDouble(gap, other.gap, t)!,
      size: lerpDouble(size, other.size, t)!,
    );
  }
}
