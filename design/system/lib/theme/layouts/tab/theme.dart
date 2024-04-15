import 'package:design/model/breakpoints.dart';
import 'package:design/model/mixins.dart';
import 'package:design/theme/layouts/tab/configuration.dart';
import 'package:design/theme/layouts/tab/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class TabBarTheme implements ThemeComponent<TabBarTheme> {
  final TabBarStyle style;
  final Breakpoints<TabBarConfiguration> configuration;

  const TabBarTheme({
    required this.style,
    required this.configuration,
  });

  @override
  TabBarTheme copyWith({
    TabBarStyle? style,
    Breakpoints<TabBarConfiguration>? configuration,
  }) =>
      TabBarTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  TabBarTheme lerp(ThemeComponent<TabBarTheme>? other, double t) {
    if (other is! TabBarTheme) return this;
    return TabBarTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
