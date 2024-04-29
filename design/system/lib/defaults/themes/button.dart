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
        focus: tokens.colors.focus,
      ),
      variantColors: {
        ButtonVariant.base: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.icon: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.filled: ButtonColors(
          content: tokens.colors.mainContent,
          border: tokens.colors.border,
          background: tokens.colors.main,
          hover: tokens.colors.mainHover,
          hoverContent: tokens.colors.mainHoverContent,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.outline: ButtonColors(
          content: tokens.colors.contentMedium,
          border: tokens.colors.border,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.text: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
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
        focus: tokens.colors.focus,
      ),
      variantColors: {
        ButtonVariant.base: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.icon: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.filled: ButtonColors(
          content: tokens.colors.mainContent,
          border: tokens.colors.border,
          background: tokens.colors.main,
          hover: tokens.colors.mainHover,
          hoverContent: tokens.colors.mainHoverContent,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.outline: ButtonColors(
          content: tokens.colors.contentMedium,
          border: tokens.colors.border,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
        ButtonVariant.text: ButtonColors(
          content: tokens.colors.contentMedium,
          border: Colors.transparent,
          background: Colors.transparent,
          hover: tokens.colors.hover,
          hoverContent: tokens.colors.contentMedium,
          focus: tokens.colors.focus,
        ),
      },
    ),
  ),
);
