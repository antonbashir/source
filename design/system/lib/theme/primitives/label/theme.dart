import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/label/configuration.dart';
import 'package:design/theme/primitives/label/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class LabelTheme implements ThemeComponent<LabelTheme> {
  final LabelStyle style;
  final LabelConfiguration configuration;

  const LabelTheme({
    required this.style,
    required this.configuration,
  });

  @override
  LabelTheme copyWith({
    LabelStyle? style,
    LabelConfiguration? configuration,
  }) =>
      LabelTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  LabelTheme lerp(ThemeComponent<LabelTheme>? other, double t) {
    if (other is! LabelTheme) return this;
    return LabelTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
