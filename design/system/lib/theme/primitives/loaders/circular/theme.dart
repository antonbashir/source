import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/loaders/circular/configuration.dart';
import 'package:design/theme/primitives/loaders/circular/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class CircularLoaderTheme implements ThemeComponent<CircularLoaderTheme> {
  final CircularLoaderStyle style;
  final Breakpoints<CircularLoaderConfiguration> configuration;

  const CircularLoaderTheme({
    required this.style,
    required this.configuration,
  });

  @override
  CircularLoaderTheme copyWith({
    CircularLoaderStyle? style,
    Breakpoints<CircularLoaderConfiguration>? configuration,
  }) =>
      CircularLoaderTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  CircularLoaderTheme lerp(CircularLoaderTheme? other, double t) {
    if (other is! CircularLoaderTheme) return this;
    return CircularLoaderTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
