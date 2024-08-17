import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/text/area/configuration.dart';
import 'package:design/theme/primitives/text/area/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextAreaTheme implements ThemeComponent<TextAreaTheme> {
  final TextAreaStyle style;
  final TextAreaConfiguration configuration;

  const TextAreaTheme({
    required this.style,
    required this.configuration,
  });

  @override
  TextAreaTheme copyWith({
    TextAreaStyle? style,
    TextAreaConfiguration? configuration,
  }) =>
      TextAreaTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  TextAreaTheme lerp(TextAreaTheme? other, double t) {
    if (other is! TextAreaTheme) return this;
    return TextAreaTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
