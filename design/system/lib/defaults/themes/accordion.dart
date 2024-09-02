part of '../defaults.dart';

final _lightAccordion = ThemeMutable(
  (Tokens tokens) => AccordionTheme(
    style: AccordionStyle(
      textColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      expandedTextColor: tokens.colors.contentMedium,
      expandedIconColor: tokens.colors.contentMedium,
      contentColor: tokens.colors.contentMedium,
      trailingIconColor: tokens.colors.contentMedium,
      expandedTrailingIconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      expandedBackgroundColor: Colors.transparent,
      borderColor: tokens.colors.border,
      dividerColor: tokens.colors.border,
      transitionDuration: tokens.transitions.transitionDuration,
      transitionCurve: tokens.transitions.transitionCurve,
      shadows: tokens.shadows.small,
    ),
    configuration: _accordionConfiguration,
  ),
);

final _darkAccordion = ThemeMutable(
  (Tokens tokens) => AccordionTheme(
    style: AccordionStyle(
      textColor: tokens.colors.contentMedium,
      expandedTextColor: tokens.colors.contentMedium,
      contentColor: tokens.colors.contentMedium,
      iconColor: tokens.colors.contentMedium,
      expandedIconColor: tokens.colors.contentMedium,
      trailingIconColor: tokens.colors.contentMedium,
      expandedTrailingIconColor: tokens.colors.contentMedium,
      backgroundColor: Colors.transparent,
      expandedBackgroundColor: Colors.transparent,
      borderColor: tokens.colors.border,
      dividerColor: tokens.colors.border,
      transitionDuration: tokens.transitions.transitionDuration,
      transitionCurve: tokens.transitions.transitionCurve,
      shadows: tokens.shadows.small,
    ),
    configuration: _accordionConfiguration,
  ),
);
