part of '../defaults.dart';

final _lightChip = ThemeMutable(
  (Tokens tokens) => ChipTheme(
    style: ChipStyle(
      activeBorderColor: tokens.colors.main,
      backgroundColor: Colors.transparent,
      activeBackgroundColor: tokens.colors.surface,
      contentColor: tokens.colors.contentMedium,
    ),
    configuration: _chipConfiguration,
  ),
);

final _darkChip = ThemeMutable(
  (Tokens tokens) => ChipTheme(
    style: ChipStyle(
      activeBorderColor: tokens.colors.main,
      backgroundColor: Colors.transparent,
      activeBackgroundColor: tokens.colors.surface,
      contentColor: tokens.colors.contentMedium,
    ),
    configuration: _chipConfiguration,
  ),
);
