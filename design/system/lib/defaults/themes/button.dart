part of '../defaults.dart';

final _lightButton = ThemeMutable(
  (Tokens tokens) => ButtonTheme(
    configuration: _buttonConfiguration,
    style: ButtonStyle(
      fallbackColors: ButtonColors(
        content: tokens.colors.contentMedium,
        border: tokens.colors.border,
        background: Colors.transparent,
        hover: tokens.colors.hover,
        hoverContent: tokens.colors.contentMedium,
        focus: tokens.colors.main,
      ),
      variantColors: {
        ButtonVariant.base: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.icon: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.filled: ButtonColors(
          content: tokens.colors.mainContent,
          border: tokens.colors.border,
          background: tokens.colors.main,
          hover: tokens.colors.mainHover,
          hoverContent: tokens.colors.mainContent,
          focus: tokens.colors.main,
        ),
        ButtonVariant.outline: ButtonColors(
          content: tokens.colors.contentMedium,
          border: tokens.colors.border,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.text: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
      },
    ),
  ),
);

final _darkButton = ThemeMutable(
  (Tokens tokens) => ButtonTheme(
    configuration: _buttonConfiguration,
    style: ButtonStyle(
      fallbackColors: ButtonColors(
        content: tokens.colors.contentMedium,
        border: tokens.colors.border,
        background: Colors.transparent,
        hover: tokens.colors.hover,
        hoverContent: tokens.colors.contentMedium,
        focus: tokens.colors.main,
      ),
      variantColors: {
        ButtonVariant.base: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.icon: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.filled: ButtonColors(
          content: tokens.colors.mainContent,
          border: tokens.colors.border,
          background: tokens.colors.main,
          hover: tokens.colors.mainHover,
          hoverContent: tokens.colors.mainContent,
          focus: tokens.colors.main,
        ),
        ButtonVariant.outline: ButtonColors(
          content: tokens.colors.contentMedium,
          border: tokens.colors.border,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
        ButtonVariant.text: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.main,
        ),
      },
    ),
  ),
);
