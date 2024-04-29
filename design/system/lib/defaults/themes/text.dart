part of '../defaults.dart';

final _lightTextArea = ThemeMutable(
  (Tokens tokens) => TextAreaTheme(
    style: TextAreaStyle(
      backgroundColor: tokens.colors.surface,
      activeBorderColor: tokens.colors.main,
      inactiveBorderColor: tokens.colors.border,
      errorColor: tokens.colors.error,
      hoverBorderColor: tokens.colors.border,
      textColor: tokens.colors.contentStrong,
      helperTextColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _textAreaConfiguration,
  ),
);

final _darkTextArea = ThemeMutable(
  (Tokens tokens) => TextAreaTheme(
    style: TextAreaStyle(
      backgroundColor: tokens.colors.surface,
      activeBorderColor: tokens.colors.border,
      inactiveBorderColor: Colors.transparent,
      errorColor: tokens.colors.error,
      hoverBorderColor: Colors.transparent,
      textColor: tokens.colors.contentStrong,
      helperTextColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _textAreaConfiguration,
  ),
);

final _lightTextInput = ThemeMutable(
  (Tokens tokens) => TextInputTheme(
    style: TextInputStyle(
      backgroundColor: tokens.colors.surface,
      activeBorderColor: tokens.colors.main,
      inactiveBorderColor: Colors.transparent,
      errorColor: tokens.colors.error,
      hoverBorderColor: Colors.transparent,
      textColor: tokens.colors.contentStrong,
      helperTextColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _textInputConfiguration,
  ),
);

final _darkTextInput = ThemeMutable(
  (Tokens tokens) => TextInputTheme(
    style: TextInputStyle(
      backgroundColor: tokens.colors.surface,
      activeBorderColor: tokens.colors.border,
      inactiveBorderColor: Colors.transparent,
      errorColor: tokens.colors.error,
      hoverBorderColor: Colors.transparent,
      textColor: tokens.colors.contentStrong,
      helperTextColor: tokens.colors.contentWeak,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _textInputConfiguration,
  ),
);
