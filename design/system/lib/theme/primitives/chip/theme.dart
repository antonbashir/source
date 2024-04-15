import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/chip/configuration.dart';
import 'package:design/theme/primitives/chip/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChipTheme implements ThemeComponent<ChipTheme> {
  final ChipStyle style;
  final Breakpoints<ChipConfiguration> configuration;

  const ChipTheme({
    required this.style,
    required this.configuration,
  });

  @override
  ChipTheme copyWith({
    ChipStyle? style,
    Breakpoints<ChipConfiguration>? configuration,
  }) =>
      ChipTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  ChipTheme lerp(ChipTheme? other, double t) {
    if (other is! ChipTheme) return this;
    return ChipTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
