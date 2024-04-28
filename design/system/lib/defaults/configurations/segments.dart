part of '../defaults.dart';

final _segmentedControlConfiguration = Breakpoints(
  SegmentedControlConfiguration(
    segmentBorderRadius: _borders.small,
    segmentGap: 8,
    height: 48,
    iconSizeValue: 24,
    segmentPadding: const EdgeInsets.symmetric(horizontal: 16),
    segmentTextStyle: _typography.base.titleMedium,
    borderRadius: _borders.medium,
    gap: 4,
    padding: const EdgeInsets.all(4),
    minTouchTargetSize: 40,
    borderType: _borders.type,
    segmentBorderType: _borders.type,
  ),
  {
    BreakpointSize.small: SegmentedControlConfiguration(
      segmentBorderRadius: _borders.small,
      segmentGap: 4,
      height: 40,
      iconSizeValue: 24,
      segmentPadding: const EdgeInsets.symmetric(horizontal: 12),
      segmentTextStyle: _typography.base.titleMedium,
      borderRadius: _borders.medium,
      gap: 4,
      padding: const EdgeInsets.all(4),
      minTouchTargetSize: 40,
      borderType: _borders.type,
      segmentBorderType: _borders.type,
    ),
    BreakpointSize.medium: SegmentedControlConfiguration(
      segmentBorderRadius: _borders.small,
      segmentGap: 8,
      height: 48,
      iconSizeValue: 24,
      segmentPadding: const EdgeInsets.symmetric(horizontal: 16),
      segmentTextStyle: _typography.base.titleMedium,
      borderRadius: _borders.medium,
      gap: 4,
      padding: const EdgeInsets.all(4),
      minTouchTargetSize: 40,
      borderType: _borders.type,
      segmentBorderType: _borders.type,
    )
  },
);
