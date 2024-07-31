import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/button/configuration.dart';
import 'package:design/theme/primitives/button/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ButtonTheme implements ThemeComponent<ButtonTheme> {
  final ButtonStyle style;
  final Breakpoints<ButtonConfiguration> configuration;

  const ButtonTheme({required this.style, required this.configuration});

  @override
  ButtonTheme copyWith({
    ButtonStyle? style,
    Breakpoints<ButtonConfiguration>? configuration,
  }) =>
      ButtonTheme(
        configuration: configuration ?? this.configuration,
        style: style ?? this.style,
      );

  @override
  ButtonTheme lerp(ButtonTheme? other, double t) {
    if (other is! ButtonTheme) return this;
    return ButtonTheme(style: style.lerp(other.style, t), configuration: configuration.lerp(other.configuration, t));
  }
}
