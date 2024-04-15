import 'dart:ui';

import 'package:design/constants/toast.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ToastStyle implements ThemeComponent<ToastStyle> {
  final Map<ToastVariant, Color> leadingColors;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final List<BoxShadow> shadows;
  final double travelDistance;
  final Duration timeBetweenToasts;
  final Duration displayDuration;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const ToastStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.leadingColors,
    required this.travelDistance,
    required this.timeBetweenToasts,
    required this.shadows,
    required this.displayDuration,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  ToastStyle copyWith({
    Map<ToastVariant, Color>? colors,
    List<BoxShadow>? shadows,
    Color? backgroundColor,
    Color? contentColor,
    Color? iconColor,
    double? travelDistance,
    Duration? timeBetweenToasts,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      ToastStyle(
        leadingColors: colors ?? this.leadingColors,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: contentColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        shadows: shadows ?? this.shadows,
        travelDistance: travelDistance ?? this.travelDistance,
        timeBetweenToasts: timeBetweenToasts ?? this.timeBetweenToasts,
        displayDuration: displayDuration ?? this.displayDuration,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  ToastStyle lerp(ThemeComponent<ToastStyle>? other, double t) {
    if (other is! ToastStyle) return this;
    return ToastStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      leadingColors: leadingColors.mapValues((key, value) => Color.lerp(value, other.leadingColors[key], t)!),
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
      travelDistance: lerpDouble(travelDistance, other.travelDistance, t)!,
      timeBetweenToasts: lerpDuration(timeBetweenToasts, other.timeBetweenToasts, t),
      displayDuration: lerpDuration(displayDuration, other.displayDuration, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
