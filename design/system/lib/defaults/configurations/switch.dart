part of '../defaults.dart';

final _switchConfiguration = Breakpoints(
  SwitchConfiguration(
    height: 24,
    width: 2 * 16 + 3 * 4,
    thumbSizeValue: 16,
    iconSizeValue: 16,
    padding: const EdgeInsets.all(4),
    textStyle: _typography.base.titleMedium.copyWith(letterSpacing: 0.1),
  ),
  {
    BreakpointSize.tiny: SwitchConfiguration(
      height: 16,
      width: 2 * 12 + 2 * 4,
      thumbSizeValue: 12,
      iconSizeValue: 12,
      padding: const EdgeInsets.all(2),
      textStyle: _typography.base.titleSmall.copyWith(letterSpacing: 0),
    ),
    BreakpointSize.small: SwitchConfiguration(
      height: 24,
      width: 2 * 16 + 3 * 4,
      thumbSizeValue: 16,
      iconSizeValue: 16,
      padding: const EdgeInsets.all(4),
      textStyle: _typography.base.titleMedium.copyWith(letterSpacing: 0.1),
    ),
    BreakpointSize.medium: SwitchConfiguration(
      height: 32,
      width: 2 * 24 + 3 * 4,
      thumbSizeValue: 24,
      iconSizeValue: 24,
      padding: const EdgeInsets.all(4),
      textStyle: _typography.base.titleLarge.copyWith(letterSpacing: 0.1),
    )
  },
);
