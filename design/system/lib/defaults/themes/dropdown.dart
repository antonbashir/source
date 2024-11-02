part of '../defaults.dart';

final _lightDropdown = ThemeMutable(
  (Tokens tokens) => DropdownTheme(
    style: DropdownStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: tokens.colors.surface,
      shadows: tokens.shadows.small,
      transitionDuration: Duration.zero,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _dropdownConfiguration,
  ),
);

final _darkDropdown = ThemeMutable(
  (Tokens tokens) => DropdownTheme(
    style: DropdownStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: tokens.colors.surface,
      shadows: tokens.shadows.small,
      transitionDuration: Duration.zero,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _dropdownConfiguration,
  ),
);
