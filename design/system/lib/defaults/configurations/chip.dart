part of '../defaults.dart';

final _chipConfiguration = Breakpoints(
  ChipConfiguration(
    borderWidth: _borders.borderWidth,
    borderRadius: _borders.large,
    gap: 8,
    height: 40,
    iconSizeValue: 24,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    textStyle: _typography.base.labelMedium,
    minTouchTargetSize: 40,
  ),
  {
    BreakpointSize.small: ChipConfiguration(
      borderWidth: _borders.borderWidth,
      borderRadius: _borders.large,
      gap: 8,
      height: 32,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: _typography.base.labelMedium,
      minTouchTargetSize: 40,
    ),
    BreakpointSize.medium: ChipConfiguration(
      borderWidth: _borders.borderWidth,
      borderRadius: _borders.large,
      gap: 8,
      height: 40,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.labelMedium,
      minTouchTargetSize: 40,
    )
  },
);
