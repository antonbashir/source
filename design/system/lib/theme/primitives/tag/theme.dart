import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/primitives/tag/configuration.dart';
import 'package:design/theme/primitives/tag/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TagTheme implements ThemeComponent<TagTheme> {
  final TagStyle style;
  final Breakpoints<TagConfiguration> configuration;

  const TagTheme({
    required this.style,
    required this.configuration,
  });

  @override
  TagTheme copyWith({
    TagStyle? style,
    Breakpoints<TagConfiguration>? configuration,
  }) =>
      TagTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  TagTheme lerp(TagTheme? other, double t) {
    if (other is! TagTheme) return this;
    return TagTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
