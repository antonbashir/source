part of '../defaults.dart';

final _lightSidebar = ThemeMutable(
  (Tokens tokens) => SidebarTheme(
    style: SidebarStyle(
      selectedTabColor: tokens.colors.active,
      selectedTextColor: tokens.colors.contentStrongActive,
      tabTextColor: tokens.colors.contentMedium,
      tabBarBackgroundColor: Colors.transparent,
      shadows: tokens.shadows.large,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
      tabBarBorderColor: Colors.transparent,
    ),
    configuration: _sidebarConfiguration,
  ),
);

final _darkSidebar = ThemeMutable(
  (Tokens tokens) => SidebarTheme(
    style: SidebarStyle(
      selectedTabColor: tokens.colors.active,
      selectedTextColor: tokens.colors.contentStrongActive,
      tabTextColor: tokens.colors.contentMedium,
      tabBarBackgroundColor: Colors.transparent,
      shadows: tokens.shadows.large,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
      tabBarBorderColor: Colors.transparent,
    ),
    configuration: _sidebarConfiguration,
  ),
);
