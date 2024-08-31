import 'package:design/model/mixins.dart';
import 'package:design/theme/layouts/sidebar/sidebar/style.dart';
import 'package:design/theme/layouts/sidebar/sidebar/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class SidebarTheme implements ThemeComponent<SidebarTheme> {
  final SidebarStyle style;
  final SidebarConfiguration configuration;

  const SidebarTheme({
    required this.style,
    required this.configuration,
  });

  @override
  SidebarTheme copyWith({
    SidebarStyle? style,
    SidebarConfiguration? configuration,
  }) =>
      SidebarTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  SidebarTheme lerp(ThemeComponent<SidebarTheme>? other, double t) {
    if (other is! SidebarTheme) return this;
    return SidebarTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
