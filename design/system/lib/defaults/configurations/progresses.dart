part of '../defaults.dart';

final _circularProgressConfiguration = Breakpoints(
  const CircularProgressConfiguration(
    progressSizeValue: 40,
    progressStrokeWidth: 2,
  ),
  {
    BreakpointSize.tiny: const CircularProgressConfiguration(
      progressSizeValue: 16,
      progressStrokeWidth: 2,
    ),
    BreakpointSize.small: const CircularProgressConfiguration(
      progressSizeValue: 24,
      progressStrokeWidth: 2,
    ),
    BreakpointSize.medium: const CircularProgressConfiguration(
      progressSizeValue: 32,
      progressStrokeWidth: 2,
    ),
    BreakpointSize.large: const CircularProgressConfiguration(
      progressSizeValue: 40,
      progressStrokeWidth: 2,
    ),
    BreakpointSize.gigantic: const CircularProgressConfiguration(
      progressSizeValue: 48,
      progressStrokeWidth: 2,
    )
  },
);

final _linearProgressConfiguration = Breakpoints(
  LinearProgressConfiguration(
    borderRadius: _borders.tiny,
    progressHeight: 8,
    thumbSizeValue: 12,
    verticalGap: 6,
    textStyle: _typography.base.bodySmall,
  ),
  {
    BreakpointSize.tiny: LinearProgressConfiguration(
      borderRadius: _borders.tiny,
      progressHeight: 2,
      thumbSizeValue: 12,
      verticalGap: 8,
      textStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.small: LinearProgressConfiguration(
      borderRadius: _borders.tiny,
      progressHeight: 4,
      thumbSizeValue: 12,
      verticalGap: 8,
      textStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.medium: LinearProgressConfiguration(
      borderRadius: _borders.tiny,
      progressHeight: 8,
      thumbSizeValue: 12,
      verticalGap: 6,
      textStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.large: LinearProgressConfiguration(
      borderRadius: _borders.tiny,
      progressHeight: 12,
      thumbSizeValue: 16,
      verticalGap: 6,
      textStyle: _typography.base.bodySmall,
    ),
    BreakpointSize.gigantic: LinearProgressConfiguration(
      borderRadius: _borders.tiny,
      progressHeight: 16,
      thumbSizeValue: 16,
      verticalGap: 4,
      textStyle: _typography.base.bodySmall,
    )
  },
);
