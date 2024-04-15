import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class CarouselConfiguration implements ThemeComponent<CarouselConfiguration> {
  final double gap;
  final TextStyle textStyle;

  const CarouselConfiguration({
    required this.gap,
    required this.textStyle,
  });

  @override
  CarouselConfiguration copyWith({
    double? gap,
    TextStyle? textStyle,
  }) =>
      CarouselConfiguration(
        gap: gap ?? this.gap,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  CarouselConfiguration lerp(ThemeComponent<CarouselConfiguration>? other, double t) {
    if (other is! CarouselConfiguration) return this;
    return CarouselConfiguration(
      gap: lerpDouble(gap, other.gap, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
