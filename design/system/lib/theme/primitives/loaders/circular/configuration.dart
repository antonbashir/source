import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';

@immutable
class CircularLoaderConfiguration implements ThemeComponent<CircularLoaderConfiguration> {
  final double loaderSizeValue;
  final double loaderStrokeWidth;

  const CircularLoaderConfiguration({
    required this.loaderSizeValue,
    required this.loaderStrokeWidth,
  });

  @override
  CircularLoaderConfiguration copyWith({
    double? loaderSizeValue,
    double? loaderStrokeWidth,
  }) =>
      CircularLoaderConfiguration(
        loaderSizeValue: loaderSizeValue ?? this.loaderSizeValue,
        loaderStrokeWidth: loaderStrokeWidth ?? this.loaderStrokeWidth,
      );

  @override
  CircularLoaderConfiguration lerp(CircularLoaderConfiguration? other, double t) {
    if (other is! CircularLoaderConfiguration) return this;
    return CircularLoaderConfiguration(
      loaderSizeValue: lerpDouble(loaderSizeValue, other.loaderSizeValue, t)!,
      loaderStrokeWidth: lerpDouble(loaderStrokeWidth, other.loaderStrokeWidth, t)!,
    );
  }
}
