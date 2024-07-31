import 'package:design/model/mixins.dart';
import 'package:flutter/widgets.dart';

@immutable
class Radiuses implements ThemeComponent<Radiuses> {
  final Radius tiny;
  final Radius small;
  final Radius medium;
  final Radius large;

  const Radiuses({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  Radiuses copyWith({
    Radius? tiny,
    Radius? small,
    Radius? medium,
    Radius? large,
  }) =>
      Radiuses(
        tiny: tiny ?? this.tiny,
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );

  @override
  Radiuses lerp(Radiuses? other, double t) {
    if (other is! Radiuses) return this;
    return Radiuses(
      tiny: Radius.lerp(tiny, other.tiny, t)!,
      small: Radius.lerp(small, other.small, t)!,
      medium: Radius.lerp(medium, other.medium, t)!,
      large: Radius.lerp(large, other.large, t)!,
    );
  }
}
