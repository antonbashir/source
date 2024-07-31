import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class AccordionStyle implements ThemeComponent<AccordionStyle> {
  final Color textColor;
  final Color expandedTextColor;
  final Color contentColor;
  final Color iconColor;
  final Color expandedIconColor;
  final Color trailingIconColor;
  final Color expandedTrailingIconColor;
  final Color backgroundColor;
  final Color expandedBackgroundColor;
  final Color borderColor;
  final Color dividerColor;
  final List<BoxShadow> shadows;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const AccordionStyle({
    required this.textColor,
    required this.expandedTextColor,
    required this.contentColor,
    required this.iconColor,
    required this.expandedIconColor,
    required this.trailingIconColor,
    required this.expandedTrailingIconColor,
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.shadows,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  AccordionStyle copyWith({
    Color? contentColor,
    Color? expandedTextColor,
    Color? textColor,
    Color? iconColor,
    Color? expandedIconColor,
    Color? trailingIconColor,
    Color? expandedTrailingIconColor,
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    Color? dividerColor,
    Duration? transitionDuration,
    Curve? transitionCurve,
    List<BoxShadow>? shadows,
  }) =>
      AccordionStyle(
        textColor: contentColor ?? this.textColor,
        expandedTextColor: expandedTextColor ?? this.expandedTextColor,
        contentColor: contentColor ?? this.contentColor,
        iconColor: iconColor ?? this.iconColor,
        expandedIconColor: expandedIconColor ?? this.expandedIconColor,
        trailingIconColor: trailingIconColor ?? this.trailingIconColor,
        expandedTrailingIconColor: expandedTrailingIconColor ?? this.expandedTrailingIconColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
        borderColor: borderColor ?? this.borderColor,
        dividerColor: dividerColor ?? this.dividerColor,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
        shadows: shadows ?? this.shadows,
      );

  @override
  AccordionStyle lerp(AccordionStyle? other, double t) {
    if (other is! AccordionStyle) return this;
    return AccordionStyle(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      expandedTextColor: Color.lerp(expandedTextColor, other.expandedTextColor, t)!,
      contentColor: Color.lerp(contentColor, other.contentColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      expandedIconColor: Color.lerp(expandedIconColor, other.expandedIconColor, t)!,
      trailingIconColor: Color.lerp(trailingIconColor, other.trailingIconColor, t)!,
      expandedTrailingIconColor: Color.lerp(expandedTrailingIconColor, other.expandedTrailingIconColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      expandedBackgroundColor: Color.lerp(expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
      transitionCurve: other.transitionCurve,
    );
  }
}
