part of '../defaults.dart';

final _lightCarousel = ThemeMutable(
  (Tokens tokens) => CarouselTheme(
    style: CarouselStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      autoPlayDelay: const Duration(seconds: 3),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.fastOutSlowIn,
    ),
    configuration: _carouselConfiguration,
  ),
);

final _darkCarousel = ThemeMutable(
  (Tokens tokens) => CarouselTheme(
    style: CarouselStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      autoPlayDelay: const Duration(seconds: 3),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.fastOutSlowIn,
    ),
    configuration: _carouselConfiguration,
  ),
);
