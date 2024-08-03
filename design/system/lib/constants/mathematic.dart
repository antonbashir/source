import 'dart:math';

const double degrees2Radians = pi / 180.0;
const double twoPi = pi * 2.0;
const double epsilon = .001;

double radians(double degrees) => degrees * degrees2Radians;
bool? lerpBool(bool? a, bool? b, double t) => t < 0.5 ? a : b;