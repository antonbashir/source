import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/switch/configuration.dart';
import 'package:design/theme/primitives/switch/style.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:flutter/foundation.dart';

@immutable
class SwitchTheme implements ThemeComponent<SwitchTheme> {
  final SwitchStyle style;
  final Breakpoints<SwitchConfiguration> configuration;

  const SwitchTheme({
    required this.style,
    required this.configuration,
  });

  @override
  SwitchTheme copyWith({
    Tokens? tokens,
    SwitchStyle? style,
    Breakpoints<SwitchConfiguration>? configuration,
  }) =>
      SwitchTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  SwitchTheme lerp(SwitchTheme? other, double t) {
    if (other is! SwitchTheme) return this;
    return SwitchTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
