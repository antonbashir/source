import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/pins/configuration.dart';
import 'package:design/theme/primitives/pins/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class ProgressPinTheme implements ThemeComponent<ProgressPinTheme> {
  final ProgressPinStyle style;
  final ProgressPinConfiguration configuration;

  const ProgressPinTheme({
    required this.style,
    required this.configuration,
  });

  @override
  ProgressPinTheme copyWith({
    ProgressPinStyle? style,
    ProgressPinConfiguration? configuration,
  }) {
    return ProgressPinTheme(
      style: style ?? this.style,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  ProgressPinTheme lerp(ProgressPinTheme? other, double t) {
    if (other is! ProgressPinTheme) return this;
    return ProgressPinTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
