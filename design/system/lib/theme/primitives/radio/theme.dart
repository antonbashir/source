import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/radio/style.dart';
import 'package:design/theme/primitives/radio/configuration.dart';
import 'package:flutter/foundation.dart';

@immutable
class RadioTheme implements ThemeComponent<RadioTheme> {
  final RadioStyle style;
  final Breakpoints<RadioConfiguration> configuration;

  const RadioTheme({
    required this.style,
    required this.configuration,
  });

  @override
  RadioTheme copyWith({
    RadioStyle? style,
    Breakpoints<RadioConfiguration>? configuration,
  }) =>
      RadioTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  RadioTheme lerp(RadioTheme? other, double t) {
    if (other is! RadioTheme) return this;
    return RadioTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
