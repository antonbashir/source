part of '../defaults.dart';

final _lightLabel = ThemeMutable(
  (Tokens tokens) => LabelTheme(
    style: LabelStyle(
      backgroundColor: Colors.transparent,
      iconColor: tokens.colors.contentMedium,
      labelTextColor: tokens.colors.contentMedium,
      contentTextColor: tokens.colors.contentWeak,
    ),
    configuration: _labelConfiguration,
  ),
);

final _darkLabel = ThemeMutable(
  (Tokens tokens) => LabelTheme(
    style: LabelStyle(
      backgroundColor: Colors.transparent,
      iconColor: tokens.colors.contentMedium,
      labelTextColor: tokens.colors.contentMedium,
      contentTextColor: tokens.colors.contentWeak,
    ),
    configuration: _labelConfiguration,
  ),
);
