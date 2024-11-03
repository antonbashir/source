part of '../defaults.dart';

final _lightAvatar = ThemeMutable(
  (Tokens tokens) => AvatarTheme(
    style: AvatarStyle(
      backgroundColor: tokens.colors.surface,
      badgeColor: tokens.colors.accent,
      iconColor: tokens.colors.contentStrong,
      textColor: tokens.colors.contentStrong,
    ),
    sizes: _avatarConfiguration,
  ),
);

final _darkAvatar = ThemeMutable(
  (Tokens tokens) => AvatarTheme(
    style: AvatarStyle(
      backgroundColor: tokens.colors.surface,
      badgeColor: tokens.colors.accent,
      iconColor: tokens.colors.contentStrong,
      textColor: tokens.colors.contentStrong,
    ),
    sizes: _avatarConfiguration,
  ),
);
