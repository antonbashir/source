import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class CircularProgressConfiguration implements ThemeComponent<CircularProgressConfiguration> {
  final double progressSizeValue;
  final double progressStrokeWidth;

  const CircularProgressConfiguration({
    required this.progressSizeValue,
    required this.progressStrokeWidth,
  });

  @override
  CircularProgressConfiguration copyWith({
    double? progressSizeValue,
    double? progressStrokeWidth,
  }) =>
      CircularProgressConfiguration(
        progressSizeValue: progressSizeValue ?? this.progressSizeValue,
        progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
      );

  @override
  CircularProgressConfiguration lerp(CircularProgressConfiguration? other, double t) {
    if (other is! CircularProgressConfiguration) return this;
    return CircularProgressConfiguration(
      progressSizeValue: lerpDouble(progressSizeValue, other.progressSizeValue, t)!,
      progressStrokeWidth: lerpDouble(progressStrokeWidth, other.progressStrokeWidth, t)!,
    );
  }
}
