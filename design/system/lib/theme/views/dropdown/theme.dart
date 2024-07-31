import 'package:design/model/mixins.dart';
import 'package:design/theme/views/dropdown/configuration.dart';
import 'package:design/theme/views/dropdown/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DropdownTheme implements ThemeComponent<DropdownTheme> {
  final DropdownStyle style;
  final DropdownConfiguration configuration;

  const DropdownTheme({
    required this.style,
    required this.configuration,
  });

  @override
  DropdownTheme copyWith({
    DropdownStyle? style,
    DropdownConfiguration? configuration,
  }) =>
      DropdownTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  DropdownTheme lerp(ThemeComponent<DropdownTheme>? other, double t) {
    if (other is! DropdownTheme) return this;
    return DropdownTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
