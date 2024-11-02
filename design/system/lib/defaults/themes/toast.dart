part of '../defaults.dart';

final _lightToast = ThemeMutable(
  (Tokens tokens) => ToastTheme(
    style: ToastStyle(
      backgroundColor: tokens.colors.neutral,
      iconColor: tokens.colors.contentMedium,
      textColor: tokens.colors.contentMedium,
      leadingColors: {
        ToastVariant.information: tokens.colors.information,
        ToastVariant.success: tokens.colors.success,
        ToastVariant.warning: tokens.colors.warning,
        ToastVariant.error: tokens.colors.error,
        ToastVariant.neutral: tokens.colors.neutral,
      },
      shadows: [],
      travelDistance: 8,
      timeBetweenToasts: const Duration(milliseconds: 200),
      displayDuration: const Duration(seconds: 3),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _toastConfiguration,
  ),
);

final _darkToast = ThemeMutable(
  (Tokens tokens) => ToastTheme(
    style: ToastStyle(
      backgroundColor: tokens.colors.neutral,
      iconColor: tokens.colors.contentMedium,
      textColor: tokens.colors.contentMedium,
      leadingColors: {
        ToastVariant.information: tokens.colors.information,
        ToastVariant.success: tokens.colors.success,
        ToastVariant.warning: tokens.colors.warning,
        ToastVariant.error: tokens.colors.error,
        ToastVariant.neutral: tokens.colors.neutral,
      },
      shadows: [],
      travelDistance: 8,
      timeBetweenToasts: const Duration(milliseconds: 200),
      displayDuration: const Duration(seconds: 3),
      transitionDuration: _transitions.transitionDuration,
      transitionCurve: _transitions.transitionCurve,
    ),
    configuration: _toastConfiguration,
  ),
);
