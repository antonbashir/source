part of '../defaults.dart';

final _lightListItem = ThemeMutable(
  (Tokens tokens) => ListItemTheme(
    style: ListItemStyle(
      backgroundColor: Colors.transparent,
      dividerColor: tokens.colors.border,
      iconColor: tokens.colors.contentMedium,
      labelTextColor: tokens.colors.contentMedium,
      contentTextColor: tokens.colors.contentWeak,
    ),
    configuration: _listItemConfiguration,
  ),
);

final _darkListItem = ThemeMutable(
  (Tokens tokens) => ListItemTheme(
    style: ListItemStyle(
      backgroundColor: tokens.colors.surface,
      dividerColor: tokens.colors.border,
      iconColor: tokens.colors.contentMedium,
      labelTextColor: tokens.colors.contentMedium,
      contentTextColor: tokens.colors.contentWeak,
    ),
    configuration: _listItemConfiguration,
  ),
);
