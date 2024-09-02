part of '../defaults.dart';

final _lightDrawer = ThemeMutable(
  (Tokens tokens) => DrawerTheme(
    style: DrawerStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      barrierColor: tokens.colors.overlay,
      shadows: tokens.shadows.large,
    ),
    configuration: _drawerConfiguration,
  ),
);

final _darkDrawer = ThemeMutable(
  (Tokens tokens) => DrawerTheme(
    style: DrawerStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      barrierColor: tokens.colors.overlay,
      shadows: tokens.shadows.large,
    ),
    configuration: _drawerConfiguration,
  ),
);
