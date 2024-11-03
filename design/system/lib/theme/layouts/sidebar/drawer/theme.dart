import 'package:design/model/mixins.dart';
import 'package:design/theme/layouts/sidebar/drawer/style.dart';
import 'package:design/theme/layouts/sidebar/drawer/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class DrawerTheme implements ThemeComponent<DrawerTheme> {
  final DrawerStyle style;
  final DrawerConfiguration configuration;

  const DrawerTheme({
    required this.style,
    required this.configuration,
  });

  @override
  DrawerTheme copyWith({
    DrawerStyle? style,
    DrawerConfiguration? configuration,
  }) =>
      DrawerTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  DrawerTheme lerp(ThemeComponent<DrawerTheme>? other, double t) {
    if (other is! DrawerTheme) return this;
    return DrawerTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
