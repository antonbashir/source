import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/text/input/configuration.dart';
import 'package:design/theme/primitives/text/input/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextInputTheme implements ThemeComponent<TextInputTheme> {
  final TextInputStyle style;
  final Breakpoints<TextInputConfiguration> configuration;

  const TextInputTheme({
    required this.style,
    required this.configuration,
  });

  @override
  TextInputTheme copyWith({
    TextInputStyle? style,
    Breakpoints<TextInputConfiguration>? configuration,
  }) =>
      TextInputTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  TextInputTheme lerp(ThemeComponent<TextInputTheme>? other, double t) {
    if (other is! TextInputTheme) return this;
    return TextInputTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
