import 'package:design/model/mixins.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:design/theme/views/carousel/configuration.dart';
import 'package:design/theme/views/carousel/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class CarouselTheme implements ThemeComponent<CarouselTheme> {
  final CarouselStyle style;
  final CarouselConfiguration configuration;

  const CarouselTheme({
    required this.style,
    required this.configuration,
  });

  @override
  CarouselTheme copyWith({
    Tokens? tokens,
    CarouselStyle? style,
    CarouselConfiguration? configuration,
  }) {
    return CarouselTheme(
      style: style ?? this.style,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  CarouselTheme lerp(ThemeComponent<CarouselTheme>? other, double t) {
    if (other is! CarouselTheme) return this;
    return CarouselTheme(
      configuration: configuration.lerp(other.configuration, t),
      style: style.lerp(other.style, t),
    );
  }
}
