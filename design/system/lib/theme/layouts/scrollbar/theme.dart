import 'package:design/model/mixins.dart';
import 'package:design/theme/layouts/scrollbar/configuration.dart';
import 'package:design/theme/layouts/scrollbar/style.dart';
import 'package:flutter/widgets.dart';

@immutable
class ScrollbarTheme implements ThemeComponent<ScrollbarTheme> {
  final ScrollbarStyle style;
  final ScrollbarConfiguration configuration;

  const ScrollbarTheme({required this.style, required this.configuration});

  @override
  ScrollbarTheme copyWith({
    ScrollbarStyle? style,
    ScrollbarConfiguration? configuration,
  }) =>
      ScrollbarTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  ScrollbarTheme lerp(ScrollbarTheme? other, double t) {
    if (other is! ScrollbarTheme) return this;
    return ScrollbarTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
