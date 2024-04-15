part of '../defaults.dart';

final _tagConfiguration = Breakpoints(
  TagConfiguration(
    borderRadius: _borders.large,
    gap: 4,
    height: 40,
    iconSizeValue: 24,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    textStyle: _typography.base.labelLarge,
  ),
  {
    BreakpointSize.tiny: TagConfiguration(
      borderRadius: _borders.large,
      gap: 2,
      height: 24,
      iconSizeValue: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      textStyle: _typography.base.labelSmall,
    ),
    BreakpointSize.small: TagConfiguration(
      borderRadius: _borders.large,
      gap: 4,
      height: 32,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.labelSmall,
    ),
    BreakpointSize.medium: TagConfiguration(
      borderRadius: _borders.large,
      gap: 4,
      height: 40,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.labelLarge,
    )
  },
);
