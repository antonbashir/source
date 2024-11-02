import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/accordion/style.dart';
import 'package:design/theme/composites/accordion/configuration.dart';
import 'package:flutter/foundation.dart';

@immutable
class AccordionTheme implements ThemeComponent<AccordionTheme> {
  final AccordionStyle style;
  final Breakpoints<AccordionConfiguration> configuration;

  const AccordionTheme({
    required this.style,
    required this.configuration,
  });

  @override
  AccordionTheme copyWith({
    AccordionStyle? style,
    Breakpoints<AccordionConfiguration>? configuration,
  }) => AccordionTheme(
      style: style ?? this.style,
      configuration: configuration ?? this.configuration,
    );

  @override
  AccordionTheme lerp(ThemeComponent<AccordionTheme>? other, double t) {
    if (other is! AccordionTheme) return this;
    return AccordionTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
