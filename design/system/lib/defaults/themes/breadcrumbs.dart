part of '../defaults.dart';

final _lightBreadcrumb = ThemeMutable(
  (Tokens tokens) => BreadcrumbsTheme(
    style: BreadcrumbsStyle(
      itemColor: tokens.colors.contentMedium,
      currentItemColor: tokens.colors.contentMediumActive,
      hoverEffectColor: tokens.colors.contentMediumHover,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _breadcrumbsConfiguration,
  ),
);

final _darkBreadcrumbs = ThemeMutable(
  (Tokens tokens) => BreadcrumbsTheme(
    style: BreadcrumbsStyle(
      itemColor: tokens.colors.contentMedium,
      currentItemColor: tokens.colors.contentMediumActive,
      hoverEffectColor: tokens.colors.contentMediumHover,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _breadcrumbsConfiguration,
  ),
);
