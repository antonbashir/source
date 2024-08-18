part of '../defaults.dart';

final _lightTag = ThemeMutable(
  (Tokens tokens) => TagTheme(
    style: TagStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: tokens.colors.surface,
    ),
    configuration: _tagConfiguration,
  ),
);

final _darkTag = ThemeMutable(
  (Tokens tokens) => TagTheme(
    style: TagStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: tokens.colors.surface,
    ),
    configuration: _tagConfiguration,
  ),
);
