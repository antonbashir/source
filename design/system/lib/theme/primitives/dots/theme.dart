import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/dots/configuration.dart';
import 'package:design/theme/primitives/dots/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DotsIndicatorTheme implements ThemeComponent<DotsIndicatorTheme> {
  final DotsIndicatorStyle style;
  final DotsIndicatorConfiguration configuration;

  const DotsIndicatorTheme({
    required this.style,
    required this.configuration,
  });

  @override
  DotsIndicatorTheme copyWith({
    DotsIndicatorStyle? style,
    DotsIndicatorConfiguration? configuration,
  }) =>
      DotsIndicatorTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  DotsIndicatorTheme lerp(DotsIndicatorTheme? other, double t) {
    if (other is! DotsIndicatorTheme) return this;
    return DotsIndicatorTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
