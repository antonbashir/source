part of '../defaults.dart';

final _lightSwitch = ThemeMutable(
  (Tokens tokens) => SwitchTheme(
    style: SwitchStyle(
      activeTrackColor: tokens.colors.main,
      inactiveTrackColor: tokens.colors.border,
      activeTextColor: tokens.colors.mainContent,
      inactiveTextColor: tokens.colors.contentWeak,
      activeIconColor: tokens.colors.mainContent,
      inactiveIconColor: tokens.colors.contentWeak,
      thumbIconColor: tokens.colors.mainContent,
      thumbColor: tokens.colors.mainContent,
      thumbShadows: tokens.shadows.small,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _switchConfiguration,
  ),
);

final _darkSwitch = ThemeMutable(
  (Tokens tokens) => SwitchTheme(
    style: SwitchStyle(
      activeTrackColor: tokens.colors.main,
      inactiveTrackColor: tokens.colors.border,
      activeTextColor: tokens.colors.mainContent,
      inactiveTextColor: tokens.colors.contentWeak,
      activeIconColor: tokens.colors.mainContent,
      inactiveIconColor: tokens.colors.contentWeak,
      thumbIconColor: tokens.colors.mainContent,
      thumbColor: tokens.colors.mainContent,
      thumbShadows: tokens.shadows.small,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _switchConfiguration,
  ),
);
