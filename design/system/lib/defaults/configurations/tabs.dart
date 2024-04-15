part of '../defaults.dart';

final _tabBarConfiguration = Breakpoints(
  TabBarConfiguration(
    borderRadius: _borders.small,
    tabGap: 8,
    height: 40,
    iconSizeValue: 20,
    indicatorHeight: 2,
    tabPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: _typography.base.titleMedium,
    gap: 8,
    minTouchTargetSize: 40,
  ),
  {
    BreakpointSize.small: TabBarConfiguration(
      borderRadius: _borders.tiny,
      tabGap: 4,
      height: 32,
      iconSizeValue: 20,
      indicatorHeight: 2,
      tabPadding: const EdgeInsets.symmetric(horizontal: 12),
      textStyle: _typography.base.titleSmall,
      minTouchTargetSize: 40,
      gap: 8,
    ),
    BreakpointSize.medium: TabBarConfiguration(
      borderRadius: _borders.small,
      tabGap: 8,
      height: 40,
      iconSizeValue: 20,
      indicatorHeight: 2,
      tabPadding: const EdgeInsets.symmetric(horizontal: 16),
      textStyle: _typography.base.titleMedium,
      gap: 8,
      minTouchTargetSize: 40,
    )
  },
);
