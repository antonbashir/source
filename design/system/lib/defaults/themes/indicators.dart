part of '../defaults.dart';

final _lightDotsIndicator = ThemeMutable(
  (Tokens tokens) => DotsIndicatorTheme(
    configuration: _dotsIndicatorConfiguration,
    style: DotsIndicatorStyle(
      selectedColor: tokens.colors.contentWeakActive,
      unselectedColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
  ),
);

final _darkDotsIndicator = ThemeMutable(
  (Tokens tokens) => DotsIndicatorTheme(
    configuration: _dotsIndicatorConfiguration,
    style: DotsIndicatorStyle(
      selectedColor: tokens.colors.contentWeakActive,
      unselectedColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
  ),
);
