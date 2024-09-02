import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/divider/configuration.dart';
import 'package:design/theme/primitives/divider/style.dart';
import 'package:flutter/widgets.dart';

@immutable
class DividerTheme implements ThemeComponent<DividerTheme> {
  final DividerStyle style;
  final DividerConfiguration configuration;

  const DividerTheme({required this.style, required this.configuration});

  @override
  DividerTheme copyWith({
    DividerStyle? style,
    DividerConfiguration? configuration,
  }) =>
      DividerTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  DividerTheme lerp(DividerTheme? other, double t) {
    if (other is! DividerTheme) return this;
    return DividerTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
