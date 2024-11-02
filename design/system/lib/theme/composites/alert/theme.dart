import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/alert/configuration.dart';
import 'package:design/theme/composites/alert/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class AlertTheme implements ThemeComponent<AlertTheme> {
  final AlertStyle style;
  final AlertConfiguration configuration;

  const AlertTheme({
    required this.style,
    required this.configuration,
  });

  @override
  AlertTheme copyWith({
    AlertStyle? style,
    AlertConfiguration? configuration,
  }) =>
      AlertTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  AlertTheme lerp(ThemeComponent<AlertTheme>? other, double t) {
    if (other is! AlertTheme) return this;
    return AlertTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
