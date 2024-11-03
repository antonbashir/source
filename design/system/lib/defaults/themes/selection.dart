part of '../defaults.dart';

final _lightSelection = ThemeMutable(
  (Tokens tokens) => TextSelectionTheme(
    cursorColor: tokens.colors.main,
    selectionColor: tokens.colors.main.withOpacity(0.40),
    selectionHandleColor: tokens.colors.main,
  ),
);

final _darkSelection = ThemeMutable(
  (Tokens tokens) => TextSelectionTheme(
    cursorColor: tokens.colors.main,
    selectionColor: tokens.colors.main.withOpacity(0.40),
    selectionHandleColor: tokens.colors.main,
  ),
);
