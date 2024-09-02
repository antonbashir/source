import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class BreadcrumbsStyle implements ThemeComponent<BreadcrumbsStyle> {
  final Color itemColor;
  final Color currentItemColor;
  final Color hoverEffectColor;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const BreadcrumbsStyle({
    required this.itemColor,
    required this.currentItemColor,
    required this.hoverEffectColor,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  BreadcrumbsStyle copyWith({
    Color? itemColor,
    Color? currentItemColor,
    Color? hoverEffectColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      BreadcrumbsStyle(
        itemColor: itemColor ?? this.itemColor,
        currentItemColor: currentItemColor ?? this.currentItemColor,
        hoverEffectColor: hoverEffectColor ?? this.hoverEffectColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  BreadcrumbsStyle lerp(
    ThemeComponent<BreadcrumbsStyle>? other,
    double t,
  ) {
    if (other is! BreadcrumbsStyle) return this;
    return BreadcrumbsStyle(
      itemColor: Color.lerp(itemColor, other.itemColor, t)!,
      currentItemColor: Color.lerp(currentItemColor, other.currentItemColor, t)!,
      hoverEffectColor: Color.lerp(hoverEffectColor, other.hoverEffectColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
