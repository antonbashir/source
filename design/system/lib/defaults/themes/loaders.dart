part of '../defaults.dart';

final _lightCircularLoader = ThemeMutable(
  (Tokens tokens) => CircularLoaderTheme(
    configuration: _circularLoaderConfiguration,
    style: CircularLoaderStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
  ),
);

final _lightLinearLoader = ThemeMutable(
  (Tokens tokens) => LinearLoaderTheme(
    configuration: _linearLoaderConfiguration,
    style: LinearLoaderStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
  ),
);

final _darkCircularLoader = ThemeMutable(
  (Tokens tokens) => CircularLoaderTheme(
    configuration: _circularLoaderConfiguration,
    style: CircularLoaderStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
  ),
);

final _darkLinearLoader = ThemeMutable(
  (Tokens tokens) => LinearLoaderTheme(
    configuration: _linearLoaderConfiguration,
    style: LinearLoaderStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
  ),
);
