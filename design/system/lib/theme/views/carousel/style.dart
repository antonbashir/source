import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class CarouselStyle implements ThemeComponent<CarouselStyle> {
  final Color textColor;
  final Color iconColor;
  final Duration autoPlayDelay;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const CarouselStyle({
    required this.textColor,
    required this.iconColor,
    required this.autoPlayDelay,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  CarouselStyle copyWith({
    Color? textColor,
    Color? iconColor,
    Duration? autoPlayDelay,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      CarouselStyle(
        textColor: textColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        autoPlayDelay: autoPlayDelay ?? this.autoPlayDelay,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  CarouselStyle lerp(ThemeComponent<CarouselStyle>? other, double t) {
    if (other is! CarouselStyle) return this;
    return CarouselStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      autoPlayDelay: lerpDuration(autoPlayDelay, other.autoPlayDelay, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
