import 'dart:ui';

import 'package:design/constants/squircle.dart';

class SquircleRadius extends Radius {
  static const zero = SquircleRadius(cornerRadius: 0, cornerSmoothing: 0);
  final double cornerSmoothing;

  const SquircleRadius({required double cornerRadius, this.cornerSmoothing = squircleSmoothing}) : super.circular(cornerRadius);

  double get cornerRadius => x;

  @override
  Radius operator -() => SquircleRadius(cornerRadius: -cornerRadius, cornerSmoothing: cornerSmoothing);

  @override
  Radius operator -(Radius other) {
    if (other is SquircleRadius) {
      return SquircleRadius(
        cornerRadius: cornerRadius - other.cornerRadius,
        cornerSmoothing: (cornerSmoothing + other.cornerSmoothing) / 2,
      );
    }

    return SquircleRadius(
      cornerRadius: cornerRadius - other.x,
      cornerSmoothing: cornerSmoothing,
    );
  }

  @override
  Radius operator +(Radius other) {
    if (other is SquircleRadius) {
      return SquircleRadius(
        cornerRadius: cornerRadius + other.cornerRadius,
        cornerSmoothing: (cornerSmoothing + other.cornerSmoothing) / 2,
      );
    }

    return SquircleRadius(
      cornerRadius: cornerRadius + other.x,
      cornerSmoothing: cornerSmoothing,
    );
  }

  @override
  SquircleRadius operator *(double operand) => SquircleRadius(
        cornerRadius: cornerRadius * operand,
        cornerSmoothing: cornerSmoothing * operand,
      );

  @override
  SquircleRadius operator /(double operand) => SquircleRadius(
        cornerRadius: cornerRadius / operand,
        cornerSmoothing: cornerSmoothing / operand,
      );

  @override
  SquircleRadius operator ~/(double operand) => SquircleRadius(
        cornerRadius: (cornerRadius ~/ operand).toDouble(),
        cornerSmoothing: (cornerSmoothing ~/ operand).toDouble(),
      );

  @override
  SquircleRadius operator %(double operand) => SquircleRadius(
        cornerRadius: cornerRadius % operand,
        cornerSmoothing: cornerSmoothing % operand,
      );

  static SquircleRadius? lerp(SquircleRadius? a, SquircleRadius? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      }
      final double k = 1.0 - t;
      return SquircleRadius(
        cornerRadius: a.cornerRadius * k,
        cornerSmoothing: a.cornerSmoothing * k,
      );
    }
    if (a == null) {
      return SquircleRadius(
        cornerRadius: b.cornerRadius * t,
        cornerSmoothing: b.cornerSmoothing * t,
      );
    }
    return SquircleRadius(
      cornerRadius: lerpDouble(a.cornerRadius, b.cornerRadius, t) ?? 0,
      cornerSmoothing: lerpDouble(a.cornerSmoothing, b.cornerSmoothing, t) ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is SquircleRadius && other.cornerRadius == cornerRadius && other.cornerSmoothing == cornerSmoothing;
  }

  @override
  int get hashCode => Object.hash(cornerRadius, cornerSmoothing);
}
