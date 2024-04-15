part of '../defaults.dart';

final _accordionConfiguration = Breakpoints(
  AccordionConfiguration(
    borderRadius: _borders.small,
    headerHeight: 40,
    iconSizeValue: 24,
    minTouchTargetSize: 40,
    headerPadding: const EdgeInsets.symmetric(horizontal: 12),
    headerTextStyle: _typography.base.titleMedium,
    contentTextStyle: _typography.base.bodyMedium,
  ),
  {
    BreakpointSize.small: AccordionConfiguration(
      borderRadius: _borders.small,
      minTouchTargetSize: 40,
      headerHeight: 32,
      iconSizeValue: 16,
      headerPadding: const EdgeInsets.symmetric(horizontal: 8),
      headerTextStyle: _typography.base.titleSmall,
      contentTextStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.medium: AccordionConfiguration(
      borderRadius: _borders.small,
      minTouchTargetSize: 40,
      headerHeight: 40,
      iconSizeValue: 24,
      headerPadding: const EdgeInsets.symmetric(horizontal: 12),
      headerTextStyle: _typography.base.titleMedium,
      contentTextStyle: _typography.base.bodyMedium,
    ),
    BreakpointSize.large: AccordionConfiguration(
      borderRadius: _borders.small,
      minTouchTargetSize: 40,
      headerHeight: 48,
      iconSizeValue: 24,
      headerPadding: const EdgeInsets.symmetric(horizontal: 12),
      headerTextStyle: _typography.base.titleMedium,
      contentTextStyle: _typography.base.bodyMedium,
    ),
    BreakpointSize.gigantic: AccordionConfiguration(
      borderRadius: _borders.small,
      minTouchTargetSize: 40,
      headerHeight: 56,
      iconSizeValue: 24,
      headerPadding: const EdgeInsets.symmetric(horizontal: 16),
      headerTextStyle: _typography.base.titleMedium,
      contentTextStyle: _typography.base.bodyLarge,
    )
  },
);
