import 'package:design/model/mixins.dart';
import 'package:design/theme/views/popover/configuration.dart';
import 'package:design/theme/views/popover/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class PopoverTheme implements ThemeComponent<PopoverTheme> {
  final PopoverStyle style;
  final PopoverConfiguration configuration;

  const PopoverTheme({
    required this.style,
    required this.configuration,
  });

  @override
  PopoverTheme copyWith({
    PopoverStyle? style,
    PopoverConfiguration? configuration,
  }) =>
      PopoverTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  PopoverTheme lerp(ThemeComponent<PopoverTheme>? other, double t) {
    if (other is! PopoverTheme) return this;
    return PopoverTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
