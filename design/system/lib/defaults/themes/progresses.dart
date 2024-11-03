part of '../defaults.dart';

final _lightCircularProgress = ThemeMutable(
  (Tokens tokens) => CircularProgressTheme(
    style: CircularProgressStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
    configuration: _circularProgressConfiguration,
  ),
);

final _lightLinearProgress = ThemeMutable(
  (Tokens tokens) => LinearProgressTheme(
    style: LinearProgressStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
      textColor: tokens.colors.contentMedium,
    ),
    configuration: _linearProgressConfiguration,
  ),
);

final _darkCircularProgress = ThemeMutable(
  (Tokens tokens) => CircularProgressTheme(
    style: CircularProgressStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
    ),
    configuration: _circularProgressConfiguration,
  ),
);

final _darkLinearProgress = ThemeMutable(
  (Tokens tokens) => LinearProgressTheme(
    style: LinearProgressStyle(
      color: tokens.colors.main,
      backgroundColor: Colors.transparent,
      textColor: tokens.colors.contentMedium,
    ),
    configuration: _linearProgressConfiguration,
  ),
);
