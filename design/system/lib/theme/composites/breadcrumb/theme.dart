import 'package:design/model/mixins.dart';
import 'package:design/theme/composites/breadcrumb/configuration.dart';
import 'package:design/theme/composites/breadcrumb/style.dart';
import 'package:flutter/foundation.dart';

@immutable
class BreadcrumbsTheme implements ThemeComponent<BreadcrumbsTheme> {
  final BreadcrumbsStyle style;
  final BreadcrumbConfiguration configuration;

  const BreadcrumbsTheme({
    required this.style,
    required this.configuration,
  });

  @override
  BreadcrumbsTheme copyWith({
    BreadcrumbsStyle? style,
    BreadcrumbConfiguration? configuration,
  }) =>
      BreadcrumbsTheme(
        style: style ?? this.style,
        configuration: configuration ?? this.configuration,
      );

  @override
  BreadcrumbsTheme lerp(ThemeComponent<BreadcrumbsTheme>? other, double t) {
    if (other is! BreadcrumbsTheme) return this;
    return BreadcrumbsTheme(
      style: style.lerp(other.style, t),
      configuration: configuration.lerp(other.configuration, t),
    );
  }
}
