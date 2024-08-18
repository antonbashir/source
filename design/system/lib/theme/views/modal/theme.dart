import 'package:design/model/mixins.dart';
import 'package:design/theme/views/modal/configuration.dart';
import 'package:design/theme/views/modal/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class ModalTheme implements ThemeComponent<ModalTheme> {
  final ModalStyle style;
  final ModalConfiguration configuration;

  const ModalTheme({
    required this.style,
    required this.configuration,
  });

  @override
  ModalTheme copyWith({
    ModalStyle? style,
    ModalConfiguration? configuration,
  }) =>
      ModalTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  ModalTheme lerp(ThemeComponent<ModalTheme>? other, double t) {
    if (other is! ModalTheme) return this;
    return ModalTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
