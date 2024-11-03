part of '../defaults.dart';

final _lightModal = ThemeMutable(
  (Tokens tokens) => ModalTheme(
    style: ModalStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      barrierColor: tokens.colors.overlay,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _modalConfiguration,
  ),
);

final _darkModal = ThemeMutable(
  (Tokens tokens) => ModalTheme(
    style: ModalStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      barrierColor: tokens.colors.overlay,
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _modalConfiguration,
  ),
);
