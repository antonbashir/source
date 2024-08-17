part of '../defaults.dart';

final _lightRadio = ThemeMutable(
  (Tokens tokens) => RadioTheme(
    style: RadioStyle(
      activeColor: tokens.colors.main,
      inactiveColor: tokens.colors.border,
      textColor: tokens.colors.mainContent,
    ),
    configuration: _radioConfiguration,
  ),
);

final _darkRadio = ThemeMutable(
  (Tokens tokens) => RadioTheme(
    style: RadioStyle(
      activeColor: tokens.colors.main,
      inactiveColor: tokens.colors.border,
      textColor: tokens.colors.mainContent,
    ),
    configuration: _radioConfiguration,
  ),
);
