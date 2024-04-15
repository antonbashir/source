import 'dart:math' as math;
import 'dart:ui';

import 'package:design/borders/squircle/processed.dart';

extension PathSquircleCornersExtensions on Path {
  void addSmoothTopRight(ProcessedSquircleRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..moveTo(
          math.max(width / 2, width - p),
          0,
        )
        ..cubicTo(
          width - (p - a),
          0,
          width - (p - a - b),
          0,
          width - (p - a - b - c),
          d,
        )
        ..relativeArcToPoint(
          Offset(
            radius.circularSectionLength,
            radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          width,
          p - a - b,
          width,
          p - a,
          width,
          math.min(height / 2, p),
        );
      return;
    }
    this
      ..moveTo(width / 2, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height / 2);
  }

  void addSmoothBottomRight(ProcessedSquircleRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          width,
          math.max(height / 2, height - p),
        )
        ..cubicTo(
          width,
          height - (p - a),
          width,
          height - (p - a - b),
          width - d,
          height - (p - a - b - c),
        )
        ..relativeArcToPoint(
          Offset(
            -radius.circularSectionLength,
            radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          width - (p - a - b),
          height,
          width - (p - a),
          height,
          math.max(width / 2, width - p),
          height,
        );
      return;
    }
    this
      ..lineTo(width, height)
      ..lineTo(width / 2, height);
  }

  void addSmoothBottomLeft(ProcessedSquircleRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          math.min(width / 2, p),
          height,
        )
        ..cubicTo(
          p - a,
          height,
          p - a - b,
          height,
          p - a - b - c,
          height - d,
        )
        ..relativeArcToPoint(
          Offset(
            -radius.circularSectionLength,
            -radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          0,
          height - (p - a - b),
          0,
          height - (p - a),
          0,
          math.max(height / 2, height - p),
        );
      return;
    }
    this
      ..lineTo(0, height)
      ..lineTo(0, height / 2);
  }

  void addSmoothTopLeft(ProcessedSquircleRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          0,
          math.min(height / 2, p),
        )
        ..cubicTo(
          0,
          p - a,
          0,
          p - a - b,
          d,
          p - a - b - c,
        )
        ..relativeArcToPoint(
          Offset(
            radius.circularSectionLength,
            -radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          p - a - b,
          0,
          p - a,
          0,
          math.min(width / 2, p),
          0,
        )
        ..close();
      return;
    }
    this
      ..lineTo(0, 0)
      ..close();
  }
}
