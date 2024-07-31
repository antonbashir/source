part of '../defaults.dart';

final _lightSegmentedControlTheme = ThemeMutable(
  (Tokens tokens) => SegmentedControlTheme(
    style: SegmentedControlStyle(
      backgroundColor: tokens.colors.surface,
      selectedSegmentColor: tokens.colors.active,
      segmentTextColor: tokens.colors.contentMedium,
      selectedSegmentTextColor: tokens.colors.contentMediumActive,
      focusEffectColor: tokens.colors.hover,
      decoration: const BoxDecoration(),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _segmentedControlConfiguration,
  ),
);

final _darkSegmentedControlTheme = ThemeMutable(
  (Tokens tokens) => SegmentedControlTheme(
    style: SegmentedControlStyle(
      backgroundColor: tokens.colors.surface,
      selectedSegmentColor: tokens.colors.active,
      segmentTextColor: tokens.colors.contentMedium,
      selectedSegmentTextColor: tokens.colors.contentMediumActive,
      focusEffectColor: tokens.colors.hover,
      decoration: const BoxDecoration(),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _segmentedControlConfiguration,
  ),
);
