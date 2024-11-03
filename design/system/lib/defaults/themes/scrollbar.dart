part of '../defaults.dart';

final _lightScrollbar = ThemeMutable(
  (Tokens tokens) => ScrollbarTheme(
    style: ScrollbarStyle(
      thumbColor: WidgetStatePropertyAll(tokens.colors.scroll),
      interactive: true,
      trackBorderColor: const WidgetStatePropertyAll(Colors.transparent),
      trackColor: WidgetStatePropertyAll(tokens.colors.scroll.withOpacity(0.7)),
      thumbVisibility: WidgetStateProperty.all(false),
      trackVisibility: WidgetStateProperty.all(false),
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
      thumbColor: WidgetStatePropertyAll(tokens.colors.scroll),
      interactive: true,
      trackBorderColor: const WidgetStatePropertyAll(Colors.transparent),
      trackColor: WidgetStatePropertyAll(tokens.colors.scroll.withOpacity(0.7)),
      thumbVisibility: WidgetStateProperty.all(false),
      trackVisibility: WidgetStateProperty.all(false),
      fadeDuration: const Duration(milliseconds: 300),
      timeToFade: const Duration(milliseconds: 600),
      hoverDuration: const Duration(milliseconds: 200),
    ),
    configuration: _scrollbarConfiguration,
  ),
);
