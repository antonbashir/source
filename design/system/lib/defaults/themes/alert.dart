part of '../defaults.dart';

final _lightAlert = ThemeMutable(
  (Tokens tokens) => AlertTheme(
    style: AlertStyle(
      backgroundColor: tokens.colors.neutral,
      borderColor: Colors.transparent,
      iconColor: tokens.colors.neutralContent,
      textColor: tokens.colors.neutralContent,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _alertConfiguration,
  ),
);

final _darkAlert = ThemeMutable(
  (Tokens tokens) => AlertTheme(
    style: AlertStyle(
      backgroundColor: tokens.colors.neutral,
      borderColor: Colors.transparent,
      iconColor: tokens.colors.neutralContent,
      textColor: tokens.colors.neutralContent,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _alertConfiguration,
  ),
);
