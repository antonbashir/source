import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class LinearLoaderConfiguration implements ThemeComponent<LinearLoaderConfiguration> {
  final BorderRadiusGeometry borderRadius;
  final double loaderHeight;

  const LinearLoaderConfiguration({
    required this.borderRadius,
    required this.loaderHeight,
  });

  @override
  LinearLoaderConfiguration copyWith({
    BorderRadiusGeometry? borderRadius,
    double? loaderHeight,
  }) =>
      LinearLoaderConfiguration(
        borderRadius: borderRadius ?? this.borderRadius,
        loaderHeight: loaderHeight ?? this.loaderHeight,
      );

  @override
  LinearLoaderConfiguration lerp(LinearLoaderConfiguration? other, double t) {
    if (other is! LinearLoaderConfiguration) return this;
    return LinearLoaderConfiguration(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      loaderHeight: lerpDouble(loaderHeight, other.loaderHeight, t)!,
    );
  }
}
