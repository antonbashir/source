import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/progress/linear/configuration.dart';
import 'package:design/theme/primitives/progress/linear/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class LinearProgressTheme implements ThemeComponent<LinearProgressTheme> {
  final LinearProgressStyle style;
  final Breakpoints<LinearProgressConfiguration> configuration;

  const LinearProgressTheme({
    required this.style,
    required this.configuration,
  });

  @override
  LinearProgressTheme copyWith({
    LinearProgressStyle? style,
    Breakpoints<LinearProgressConfiguration>? configuration,
  }) =>
      LinearProgressTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  LinearProgressTheme lerp(LinearProgressTheme? other, double t) {
    if (other is! LinearProgressTheme) return this;
    return LinearProgressTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
