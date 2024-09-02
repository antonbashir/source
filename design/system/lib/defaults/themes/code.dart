part of '../defaults.dart';

final _lightCode = ThemeMutable(
  (Tokens tokens) => CodeTheme(
    style: CodeStyle(
      styles: ideaTheme.copyAdd(
        codeEditorRootClassName,
        TextStyle(
          color: const Color(0xff000000),
          backgroundColor: tokens.palette.gray.shade100.withOpacity(0.1),
        ),
      ),
    ),
  ),
);

final _darkCode = ThemeMutable(
  (Tokens tokens) => const CodeTheme(
    style: CodeStyle(styles: draculaTheme),
  ),
);
