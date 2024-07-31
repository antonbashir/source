part of '../defaults.dart';

final _lightPopover = ThemeMutable(
  (Tokens tokens) => PopoverTheme(
    style: PopoverStyle(
      textColor: tokens.colors.neutralContent,
      iconColor: tokens.colors.neutralContent,
      backgroundColor: tokens.colors.neutral,
      borderColor: Colors.transparent,
      shadows: tokens.shadows.small,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _popoverConfiguration,
  ),
);

final _darkPopover = ThemeMutable(
  (Tokens tokens) => PopoverTheme(
    style: PopoverStyle(
      textColor: tokens.colors.neutralContent,
      iconColor: tokens.colors.neutralContent,
      backgroundColor: tokens.colors.neutral,
      shadows: tokens.shadows.small,
      borderColor: Colors.transparent,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _popoverConfiguration,
  ),
);
