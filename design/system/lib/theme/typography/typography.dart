import 'package:design/theme/typography/styles.dart';
import 'package:flutter/foundation.dart';

@immutable
class Typography {
  final TextStyles base;
  final TextStyles dense;
  final TextStyles tall;

  const Typography({
    required this.base,
    required this.dense,
    required this.tall,
  });

  Typography copyWith({
    TextStyles? base,
    TextStyles? dense,
    TextStyles? tall,
  }) =>
      Typography(
        base: base ?? this.base,
        dense: dense ?? this.dense,
        tall: tall ?? this.tall,
      );

  Typography lerp(Typography? other, double t) {
    if (other is! Typography) return this;
    return Typography(
      base: base.lerp(other.base, t),
      dense: dense.lerp(other.dense, t),
      tall: tall.lerp(other.tall, t),
    );
  }
}
