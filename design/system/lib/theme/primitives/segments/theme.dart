import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/segments/style.dart';
import 'package:design/theme/primitives/segments/configuration.dart';
import 'package:flutter/widgets.dart';

@immutable
class SegmentedControlTheme implements ThemeComponent<SegmentedControlTheme> {
  final SegmentedControlStyle style;
  final Breakpoints<SegmentedControlConfiguration> configuration;

  const SegmentedControlTheme({
    required this.style,
    required this.configuration,
  });

  @override
  SegmentedControlTheme copyWith({
    SegmentedControlStyle? style,
    Breakpoints<SegmentedControlConfiguration>? configuration,
  }) =>
      SegmentedControlTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  SegmentedControlTheme lerp(SegmentedControlTheme? other, double t) {
    if (other is! SegmentedControlTheme) return this;
    return SegmentedControlTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
