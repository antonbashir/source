import 'package:design/model/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class Transitions implements ThemeComponent<Transitions> {
  final Duration transitionDuration;
  final Curve transitionCurve;

  const Transitions({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  Transitions copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) =>
      Transitions(
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionCurve: transitionCurve ?? this.transitionCurve,
      );

  @override
  Transitions lerp(Transitions? other, double t) {
    if (other is! Transitions) return this;
    return Transitions(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }
}
