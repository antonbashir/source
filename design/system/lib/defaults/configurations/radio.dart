part of '../defaults.dart';

final _radioConfiguration = Breakpoints(
  RadioConfiguration(
    borderRadius: _borders.tiny,
    textStyle: _typography.base.titleMedium,
    tapAreaSizeValue: 16,
    size: 16,
    outerRadius: 8.0,
    innerRadius: 4.0,
  ),
  {
    BreakpointSize.tiny: RadioConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleMedium,
      tapAreaSizeValue: 12,
      size: 12,
      outerRadius: 6.0,
      innerRadius: 3.0,
    ),
    BreakpointSize.small: RadioConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleMedium,
      tapAreaSizeValue: 16,
      size: 16,
      outerRadius: 8.0,
      innerRadius: 4.0,
    ),
    BreakpointSize.medium: RadioConfiguration(
      borderRadius: _borders.tiny,
      textStyle: _typography.base.titleMedium,
      tapAreaSizeValue: 20,
      size: 20,
      outerRadius: 10.0,
      innerRadius: 6.0,
    ),
  },
);
