import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Shadows implements ThemeComponent<Shadows> {
  final List<BoxShadow> small;
  final List<BoxShadow> medium;
  final List<BoxShadow> large;
  final List<BoxShadow> gigantic;

  const Shadows({
    required this.small,
    required this.medium,
    required this.large,
    required this.gigantic,
  });

  @override
  Shadows copyWith({
    List<BoxShadow>? small,
    List<BoxShadow>? medium,
    List<BoxShadow>? large,
    List<BoxShadow>? gigantic,
  }) =>
      Shadows(
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
        gigantic: gigantic ?? this.gigantic,
      );

  @override
  Shadows lerp(Shadows? other, double t) {
    if (other is! Shadows) return this;
    return Shadows(
      small: BoxShadow.lerpList(small, other.small, t)!,
      medium: BoxShadow.lerpList(medium, other.medium, t)!,
      large: BoxShadow.lerpList(large, other.large, t)!,
      gigantic: BoxShadow.lerpList(gigantic, other.gigantic, t)!,
    );
  }
}
