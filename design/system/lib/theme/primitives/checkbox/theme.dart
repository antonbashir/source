import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/checkbox/style.dart';
import 'package:design/theme/primitives/checkbox/configuration.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:flutter/foundation.dart';

@immutable
class CheckboxTheme implements ThemeComponent<CheckboxTheme> {
  final CheckboxStyle style;
  final Breakpoints<CheckboxConfiguration> configuration;

  const CheckboxTheme({required this.style, required this.configuration});

  @override
  CheckboxTheme copyWith({Tokens? tokens, CheckboxStyle? style, Breakpoints<CheckboxConfiguration>? configuration}) => CheckboxTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  CheckboxTheme lerp(CheckboxTheme? other, double t) {
    if (other is! CheckboxTheme) return this;
    return CheckboxTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
