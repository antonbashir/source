import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/loaders/linear/configuration.dart';
import 'package:design/theme/primitives/loaders/linear/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class LinearLoaderTheme implements ThemeComponent<LinearLoaderTheme> {
  final LinearLoaderStyle style;
  final Breakpoints<LinearLoaderConfiguration> configuration;

  const LinearLoaderTheme({
    required this.style,
    required this.configuration,
  });

  @override
  LinearLoaderTheme copyWith({
    LinearLoaderStyle? style,
    Breakpoints<LinearLoaderConfiguration>? configuration,
  }) =>
      LinearLoaderTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  LinearLoaderTheme lerp(LinearLoaderTheme? other, double t) {
    if (other is! LinearLoaderTheme) return this;
    return LinearLoaderTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
