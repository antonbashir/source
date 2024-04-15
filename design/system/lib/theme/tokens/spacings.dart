import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Spacings implements ThemeComponent<Spacings> {
  final Map<String, double> _spacings;

  const Spacings(this._spacings);

  double get spacingZero => _spacings["0"]!;
  double get spacingPixel => _spacings["px"]!;
  double get spacingHalf => _spacings["0.5"]!;
  double get spacing1 => _spacings["1"]!;
  double get spacingOneHalf => _spacings["1.5"]!;
  double get spacing2 => _spacings["2"]!;
  double get spacingTwoHalf => _spacings["2.5"]!;
  double get spacing3 => _spacings["3"]!;
  double get spacingThreeHalf => _spacings["3.5"]!;
  double get spacing4 => _spacings["4"]!;
  double get spacing5 => _spacings["5"]!;
  double get spacing6 => _spacings["6"]!;
  double get spacing7 => _spacings["7"]!;
  double get spacing8 => _spacings["8"]!;
  double get spacing9 => _spacings["9"]!;
  double get spacing10 => _spacings["10"]!;
  double get spacing11 => _spacings["11"]!;
  double get spacing12 => _spacings["12"]!;
  double get spacing14 => _spacings["14"]!;
  double get spacing16 => _spacings["16"]!;
  double get spacing20 => _spacings["20"]!;
  double get spacing24 => _spacings["24"]!;
  double get spacing28 => _spacings["28"]!;
  double get spacing32 => _spacings["32"]!;
  double get spacing36 => _spacings["36"]!;
  double get spacing40 => _spacings["40"]!;
  double get spacing44 => _spacings["44"]!;
  double get spacing48 => _spacings["48"]!;
  double get spacing52 => _spacings["52"]!;
  double get spacing56 => _spacings["56"]!;
  double get spacing60 => _spacings["60"]!;
  double get spacing64 => _spacings["64"]!;
  double get spacing72 => _spacings["72"]!;
  double get spacing80 => _spacings["80"]!;
  double get spacing96 => _spacings["96"]!;

  double get tiny => spacing1;
  double get small => spacing2;
  double get medium => spacing4;
  double get large => spacing8;

  @override
  Spacings copyWith({Map<String, double>? spacings}) => Spacings(spacings ?? _spacings);

  @override
  Spacings lerp(covariant Spacings? other, double t) {
    if (identical(this, other)) {
      return this;
    }

    if (other == null) {
      return this;
    }

    return Spacings(_spacings.map((String key, double size) => MapEntry<String, double>(key, lerpDouble(size, other._spacings[key]!, t)!)));
  }
}
