part of '../defaults.dart';

final _buttonConfiguration = Breakpoints(
  ButtonConfiguration(
    borderWidth: _borders.inactiveWidth,
    borderRadius: _borders.small,
    gap: 8,
    height: 40,
    iconSizeValue: 24,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    textStyle: _typography.base.titleMedium,
    minTouchTargetSize: 40,
    borderType: _borders.type,
  ),
  {
    BreakpointSize.tiny: ButtonConfiguration(
      borderWidth: _borders.inactiveWidth,
      borderRadius: _borders.small,
      gap: 4,
      height: 24,
      iconSizeValue: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: _typography.base.titleSmall,
      minTouchTargetSize: 40,
      borderType: _borders.type,
    ),
    BreakpointSize.small: ButtonConfiguration(
      borderWidth: _borders.inactiveWidth,
      borderRadius: _borders.small,
      gap: 4,
      height: 32,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      textStyle: _typography.base.titleSmall,
      minTouchTargetSize: 40,
      borderType: _borders.type,
    ),
    BreakpointSize.medium: ButtonConfiguration(
      borderWidth: _borders.inactiveWidth,
      borderRadius: _borders.small,
      gap: 8,
      height: 40,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.titleMedium,
      minTouchTargetSize: 40,
      borderType: _borders.type,
    ),
    BreakpointSize.large: ButtonConfiguration(
      borderWidth: _borders.inactiveWidth,
      borderRadius: _borders.medium,
      gap: 12,
      height: 48,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.headlineSmall,
      minTouchTargetSize: 40,
      borderType: _borders.type,
    ),
    BreakpointSize.gigantic: ButtonConfiguration(
      borderWidth: _borders.inactiveWidth,
      borderRadius: _borders.medium,
      gap: 16,
      height: 56,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      textStyle: _typography.base.headlineSmall,
      minTouchTargetSize: 40,
      borderType: _borders.type,
    )
  },
);
