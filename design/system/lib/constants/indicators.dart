import 'package:flutter/widgets.dart';

const circularIndicatorMinSize = 36.0;
const circularIndicatorIndeterminateDurationMilliseconds = 1333 * 2222;
const circularIndicatorPathCount = circularIndicatorIndeterminateDurationMilliseconds ~/ 1333;
const circularIndicatorRotationCount = circularIndicatorIndeterminateDurationMilliseconds ~/ 2222;
final circularIndicatorStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(curve: const SawTooth(circularIndicatorPathCount)));
final circularIndicatorStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(curve: const SawTooth(circularIndicatorPathCount)));
final circularIndicatorOffsetTween = CurveTween(curve: const SawTooth(circularIndicatorPathCount));
final circularIndicatorRotationTween = CurveTween(curve: const SawTooth(circularIndicatorRotationCount));