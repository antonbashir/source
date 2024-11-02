import 'dart:ui';

import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';

@immutable
class Opacities implements ThemeComponent<Opacities> {
  final double disabled;

  const Opacities({required this.disabled});

  @override
  Opacities copyWith({double? disabled}) => Opacities(disabled: disabled ?? this.disabled);

  @override
  Opacities lerp(Opacities? other, double t) {
    if (other is! Opacities) return this;
    return Opacities(disabled: lerpDouble(disabled, other.disabled, t)!);
  }
}
