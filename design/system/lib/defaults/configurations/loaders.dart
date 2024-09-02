part of '../defaults.dart';

final _circularLoaderConfiguration = Breakpoints(
  const CircularLoaderConfiguration(
    loaderSizeValue: 40,
    loaderStrokeWidth: 2,
  ),
  {
    BreakpointSize.tiny: const CircularLoaderConfiguration(
      loaderSizeValue: 16,
      loaderStrokeWidth: 2,
    ),
    BreakpointSize.small: const CircularLoaderConfiguration(
      loaderSizeValue: 24,
      loaderStrokeWidth: 2,
    ),
    BreakpointSize.medium: const CircularLoaderConfiguration(
      loaderSizeValue: 32,
      loaderStrokeWidth: 2,
    ),
    BreakpointSize.large: const CircularLoaderConfiguration(
      loaderSizeValue: 40,
      loaderStrokeWidth: 2,
    ),
    BreakpointSize.gigantic: const CircularLoaderConfiguration(
      loaderSizeValue: 48,
      loaderStrokeWidth: 2,
    )
  },
);

final _linearLoaderConfiguration = Breakpoints(
  LinearLoaderConfiguration(
    borderRadius: _borders.tiny,
    loaderHeight: 8,
  ),
  {
    BreakpointSize.tiny: LinearLoaderConfiguration(
      borderRadius: _borders.tiny,
      loaderHeight: 2,
    ),
    BreakpointSize.small: LinearLoaderConfiguration(
      borderRadius: _borders.tiny,
      loaderHeight: 4,
    ),
    BreakpointSize.medium: LinearLoaderConfiguration(
      borderRadius: _borders.tiny,
      loaderHeight: 8,
    ),
    BreakpointSize.large: LinearLoaderConfiguration(
      borderRadius: _borders.tiny,
      loaderHeight: 12,
    ),
    BreakpointSize.gigantic: LinearLoaderConfiguration(
      borderRadius: _borders.tiny,
      loaderHeight: 16,
    )
  },
);
