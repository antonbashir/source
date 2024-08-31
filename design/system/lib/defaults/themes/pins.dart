part of '../defaults.dart';

final _lightProgressPinTheme = ThemeMutable(
  (Tokens tokens) => ProgressPinTheme(
    style: ProgressPinStyle(
      pinColor: tokens.colors.surface,
      pinBorderColor: Colors.transparent,
      thumbColor: tokens.colors.surface,
      shadowColor: Colors.transparent,
      textColor: tokens.colors.contentWeak,
      showShadow: false,
      shadowElevation: 0,
    ),
    configuration: _progressPinConfiguration,
  ),
);

final _darkProgressPinTheme = ThemeMutable(
  (Tokens tokens) => ProgressPinTheme(
    style: ProgressPinStyle(
      pinColor: tokens.colors.surface,
      pinBorderColor: Colors.transparent,
      thumbColor: tokens.colors.surface,
      shadowColor: Colors.transparent,
      textColor: tokens.colors.contentWeak,
      showShadow: false,
      shadowElevation: 0,
    ),
    configuration: _progressPinConfiguration,
  ),
);
