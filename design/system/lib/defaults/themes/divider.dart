part of '../defaults.dart';

final _lightDivider = ThemeMutable(
  (Tokens tokens) => DividerTheme(
    configuration: _dividerConfiguration,
    style: DividerStyle(
      color: tokens.colors.border,
    ),
  ),
);

final _darkDivider = ThemeMutable(
  (Tokens tokens) => DividerTheme(
    configuration: _dividerConfiguration,
    style: DividerStyle(
      color: tokens.colors.border,
    ),
  ),
);
