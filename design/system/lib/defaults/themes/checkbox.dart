part of '../defaults.dart';

final _lightCheckbox = ThemeMutable(
  (Tokens tokens) => CheckboxTheme(
    style: CheckboxStyle(
      activeColor: tokens.colors.main,
      borderColor: tokens.colors.border,
      checkColor: tokens.colors.mainContent,
      inactiveColor: tokens.colors.surface,
    ),
    configuration: _checkboxConfiguration,
  ),
);

final _darkCheckbox = ThemeMutable(
  (Tokens tokens) => CheckboxTheme(
    style: CheckboxStyle(
      activeColor: tokens.colors.main,
      borderColor: tokens.colors.border,
      checkColor: tokens.colors.mainContent,
      inactiveColor: tokens.colors.surface,
    ),
    configuration: _checkboxConfiguration,
  ),
);
