import 'dart:math';

import 'package:design/constants/mathematic.dart';
import 'package:flutter/widgets.dart';

const paintingCircularProgressSweep = twoPi - epsilon;
const paintingCircularProgressStartAngle = -pi / 2.0;
const paintingLinearProgressIndeterminateDuration = 1800;

const paintingLinearProgressLine1Head = Interval(
  0.0,
  750.0 / paintingLinearProgressIndeterminateDuration,
  curve: Cubic(0.2, 0.0, 0.8, 1.0),
);

const paintingLinearProgressLine1Tail = Interval(
  333.0 / paintingLinearProgressIndeterminateDuration,
  (333.0 + 750.0) / paintingLinearProgressIndeterminateDuration,
  curve: Cubic(0.4, 0.0, 1.0, 1.0),
);

const paintingLinearProgressLine2Head = Interval(
  1000.0 / paintingLinearProgressIndeterminateDuration,
  (1000.0 + 567.0) / paintingLinearProgressIndeterminateDuration,
  curve: Cubic(0.0, 0.0, 0.65, 1.0),
);

const paintingLinearProgressLine2Tail = Interval(
  1267.0 / paintingLinearProgressIndeterminateDuration,
  (1267.0 + 533.0) / paintingLinearProgressIndeterminateDuration,
  curve: Cubic(0.10, 0.0, 0.45, 1.0),
);
