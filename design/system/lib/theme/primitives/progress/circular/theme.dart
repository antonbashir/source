import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/progress/circular/configuration.dart';
import 'package:design/theme/primitives/progress/circular/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class CircularProgressTheme implements ThemeComponent<CircularProgressTheme> {
  final CircularProgressStyle style;
  final Breakpoints<CircularProgressConfiguration> configuration;

  const CircularProgressTheme({
    required this.style,
    required this.configuration,
  });

  @override
  CircularProgressTheme copyWith({
    CircularProgressStyle? style,
    Breakpoints<CircularProgressConfiguration>? configuration,
  }) =>
      CircularProgressTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  CircularProgressTheme lerp(CircularProgressTheme? other, double t) {
    if (other is! CircularProgressTheme) return this;
    return CircularProgressTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
