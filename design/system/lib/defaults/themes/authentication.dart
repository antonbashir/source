part of '../defaults.dart';

final _lightAuthentication = ThemeMutable(
  (Tokens tokens) => AuthenticationCodeTheme(
    style: AuthenticationCodeStyle(
      selectedBorderColor: tokens.colors.focus,
      activeBorderColor: tokens.colors.border,
      inactiveBorderColor: tokens.colors.border,
      errorBorderColor: tokens.colors.error,
      selectedFillColor: tokens.colors.surface,
      activeFillColor: tokens.colors.surface,
      inactiveFillColor: tokens.colors.surface,
      textColor: tokens.colors.contentStrong,
      animationDuration: _transitions.transitionDuration,
      errorAnimationDuration: _transitions.transitionDuration,
      peekDuration: _transitions.transitionDuration,
      animationCurve: _transitions.transitionCurve,
      errorAnimationCurve: _transitions.transitionCurve,
    ),
    configuration: _authenticationCodeConfiguration,
  ),
);

final _darkAuthentication = ThemeMutable(
  (Tokens tokens) => AuthenticationCodeTheme(
    style: AuthenticationCodeStyle(
      selectedBorderColor: tokens.colors.focus,
      activeBorderColor: tokens.colors.border,
      inactiveBorderColor: tokens.colors.border,
      errorBorderColor: tokens.colors.error,
      selectedFillColor: tokens.colors.surface,
      activeFillColor: tokens.colors.surface,
      inactiveFillColor: tokens.colors.surface,
      textColor: tokens.colors.contentStrong,
      animationDuration: _transitions.transitionDuration,
      errorAnimationDuration: _transitions.transitionDuration,
      peekDuration: _transitions.transitionDuration,
      animationCurve: _transitions.transitionCurve,
      errorAnimationCurve: _transitions.transitionCurve,
    ),
    configuration: _authenticationCodeConfiguration,
  ),
);
