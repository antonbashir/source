part of '../defaults.dart';

final _textAreaConfiguration = TextAreaConfiguration(
  borderRadius: _borders.small,
  helperPadding: const EdgeInsets.only(top: 8),
  textPadding: const EdgeInsets.all(16),
  textStyle: _typography.base.bodyMedium,
  helperTextStyle: _typography.base.bodySmall,
);

final _textInputConfiguration = Breakpoints(
  TextInputConfiguration(
    borderRadius: _borders.small,
    height: 40,
    width: 150,
    gap: 8,
    iconSizeValue: 24,
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    textStyle: _typography.base.bodyMedium,
    helperPadding: const EdgeInsets.only(top: 8),
    helperTextStyle: _typography.base.bodySmall,
  ),
  {
    BreakpointSize.small: TextInputConfiguration(
      borderRadius: _borders.small,
      height: 32,
      width: 100,
      gap: 8,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      textStyle: _typography.base.bodySmall,
      helperPadding: const EdgeInsets.only(top: 8),
      helperTextStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.medium: TextInputConfiguration(
      borderRadius: _borders.small,
      height: 40,
      width: 150,
      gap: 8,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      textStyle: _typography.base.bodyMedium,
      helperPadding: const EdgeInsets.only(top: 8),
      helperTextStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.large: TextInputConfiguration(
      borderRadius: _borders.small,
      height: 48,
      width: 200,
      gap: 8,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      textStyle: _typography.base.bodyLarge,
      helperPadding: const EdgeInsets.only(top: 8),
      helperTextStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.gigantic: TextInputConfiguration(
      borderRadius: _borders.small,
      height: 56,
      width: 350,
      gap: 16,
      iconSizeValue: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 9,
      ),
      textStyle: _typography.base.bodyLarge,
      helperPadding: const EdgeInsets.only(top: 8),
      helperTextStyle: _typography.base.bodySmall,
    )
  },
);
