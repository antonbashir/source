part of '../defaults.dart';

final _lightTabBar = ThemeMutable(
  (Tokens tokens) => TabBarTheme(
    style: TabBarStyle(
      indicatorColor: tokens.colors.main,
      segmentTextColor: tokens.colors.contentWeak,
      selectedSegmentTextColor: tokens.colors.contentWeakActive,
      selectedPillTextColor: tokens.colors.contentWeakActive,
      selectedPillTabColor: tokens.colors.active,
      animationDuration: const Duration(milliseconds: 300),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _tabBarConfiguration,
  ),
);

final _darkTabBar = ThemeMutable(
  (Tokens tokens) => TabBarTheme(
    style: TabBarStyle(
      indicatorColor: tokens.colors.main,
      segmentTextColor: tokens.colors.contentWeak,
      selectedSegmentTextColor: tokens.colors.contentWeakActive,
      selectedPillTextColor: tokens.colors.contentWeakActive,
      selectedPillTabColor: tokens.colors.active,
      animationDuration: const Duration(milliseconds: 300),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _tabBarConfiguration,
  ),
);
