import 'dart:math' as math;

import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/mathematic.dart';

class SquircleProcessedRadius {
  final SquircleRadius radius;
  final double a;
  final double b;
  final double c;
  final double d;
  final double p;
  final double circularSectionLength;
  final double width;
  final double height;

  factory SquircleProcessedRadius(SquircleRadius radius, {required double width, required double height}) {
    final maxRadius = math.min(width, height) / 2;
    final cornerSmoothing = radius.cornerSmoothing;
    final cornerRadius = math.min(radius.cornerRadius, maxRadius);
    final p = math.min((1 + cornerSmoothing) * cornerRadius, maxRadius);

    final double angleAlpha;
    final double angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - cornerSmoothing);
      angleAlpha = 45 * cornerSmoothing;
    } else {
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);
      angleBeta = 90 * (1 - cornerSmoothing * (1 - diffRatio));
      angleAlpha = 45 * cornerSmoothing * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;
    final p3ToP4Distance = cornerRadius * math.tan(radians(angleTheta / 2));
    final circularSectionLength = math.sin(radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);
    final c = p3ToP4Distance * math.cos(radians(angleAlpha));
    final d = c * math.tan(radians(angleAlpha));
    final b = (p - circularSectionLength - c - d) / 3;
    final a = 2 * b;

    return SquircleProcessedRadius._(
      a: a,
      b: b,
      c: c,
      d: d,
      p: p,
      width: width,
      height: height,
      radius: SquircleRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: radius.cornerSmoothing,
      ),
      circularSectionLength: circularSectionLength,
    );
  }

  const SquircleProcessedRadius._({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.p,
    required this.width,
    required this.height,
    required this.radius,
    required this.circularSectionLength,
  });

  double get cornerRadius => radius.cornerRadius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is SquircleRadius) {
      return other == radius;
    }
    if (other is SquircleProcessedRadius) {
      return other.radius == radius;
    }
    return false;
  }

  @override
  int get hashCode => radius.hashCode;
}
