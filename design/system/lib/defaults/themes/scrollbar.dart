part of '../defaults.dart';

final _lightScrollbar = ThemeMutable(
  (Tokens tokens) => ScrollbarTheme(
    style: ScrollbarStyle(
      thumbColor: VisualStatePropertyAll(tokens.colors.scroll),
      interactive: true,
      trackBorderColor: const VisualStatePropertyAll(Colors.transparent),
      trackColor: VisualStatePropertyAll(tokens.colors.scroll.withOpacity(0.7)),
      thumbVisibility: VisualStateProperty.all(false),
      trackVisibility: VisualStateProperty.all(false),
      fadeDuration: const Duration(milliseconds: 300),
      timeToFade: const Duration(milliseconds: 600),
      hoverDuration: const Duration(milliseconds: 200),
    ),
    configuration: _scrollbarConfiguration,
  ),
);

final _darkScrollbar = ThemeMutable(
  (Tokens tokens) => ScrollbarTheme(
    style: ScrollbarStyle(
      thumbColor: VisualStatePropertyAll(tokens.colors.scroll),
      interactive: true,
      trackBorderColor: const VisualStatePropertyAll(Colors.transparent),
      trackColor: VisualStatePropertyAll(tokens.colors.scroll.withOpacity(0.7)),
      thumbVisibility: VisualStateProperty.all(false),
      trackVisibility: VisualStateProperty.all(false),
      fadeDuration: const Duration(milliseconds: 300),
      timeToFade: const Duration(milliseconds: 600),
      hoverDuration: const Duration(milliseconds: 200),
    ),
    configuration: _scrollbarConfiguration,
  ),
);
