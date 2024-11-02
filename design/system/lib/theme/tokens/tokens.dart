import 'package:design/model/mixins.dart';
import 'package:design/theme/tokens/borders.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/theme/tokens/opacities.dart';
import 'package:design/theme/tokens/palette.dart';
import 'package:design/theme/tokens/shadows.dart';
import 'package:design/theme/tokens/spacings.dart';
import 'package:design/theme/tokens/transitions.dart';
import 'package:design/theme/typography/typography.dart';
import 'package:flutter/foundation.dart';

@immutable
class Tokens implements ThemeComponent<Tokens> {
  final Borders borders;
  final Palette palette;
  final Colors colors;
  final Opacities opacities;
  final Shadows shadows;
  final Spacings spacings;
  final Transitions transitions;
  final Typography typography;

  const Tokens({
    required this.borders,
    required this.palette,
    required this.colors,
    required this.opacities,
    required this.shadows,
    required this.spacings,
    required this.transitions,
    required this.typography,
  });

  @override
  Tokens copyWith({
    Borders? borders,
    Palette? palette,
    Colors? colors,
    Opacities? opacities,
    Shadows? shadows,
    Spacings? spacings,
    Transitions? transitions,
    Typography? typography,
  }) =>
      Tokens(
        borders: borders ?? this.borders,
        palette: palette ?? this.palette,
        colors: colors ?? this.colors,
        opacities: opacities ?? this.opacities,
        shadows: shadows ?? this.shadows,
        spacings: spacings ?? this.spacings,
        transitions: transitions ?? this.transitions,
        typography: typography ?? this.typography,
      );

  @override
  Tokens lerp(Tokens? other, double t) {
    if (other is! Tokens) return this;
    return Tokens(
      borders: borders.lerp(other.borders, t),
      palette: palette.lerp(other.palette, t),
      colors: colors.lerp(other.colors, t),
      opacities: opacities.lerp(other.opacities, t),
      shadows: shadows.lerp(other.shadows, t),
      spacings: spacings.lerp(other.spacings, t),
      transitions: transitions.lerp(other.transitions, t),
      typography: typography.lerp(other.typography, t),
    );
  }
}
