part of '../defaults.dart';

final _checkboxConfiguration = Breakpoints(
  CheckboxConfiguration(
    borderRadius: _borders.tiny,
    textStyle: _typography.base.titleLarge,
    tapAreaSizeValue: 24,
    size: 24,
    strokeWidth: 2,
  ),
  {
    BreakpointSize.tiny: CheckboxConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleLarge,
      tapAreaSizeValue: 16,
      size: 16,
      strokeWidth: 2,
    ),
    BreakpointSize.small: CheckboxConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleLarge,
      tapAreaSizeValue: 24,
      size: 24,
      strokeWidth: 2,
    ),
    BreakpointSize.medium: CheckboxConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleLarge,
      tapAreaSizeValue: 32,
      size: 32,
      strokeWidth: 2,
    ),
  },
);
