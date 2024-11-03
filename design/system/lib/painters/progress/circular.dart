import 'dart:math' as math;

import 'package:design/constants/mathematic.dart';
import 'package:design/constants/progresses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class CircularProgressIndicatorPainter extends CustomPainter {
  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;
  final StrokeCap strokeCap;

  CircularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
    required this.strokeCap,
  })  : arcStart = value != null ? paintingCircularProgressStartAngle : paintingCircularProgressStartAngle + tailValue * 3 / 2 * math.pi + rotationValue * math.pi * 2.0 + offsetValue * 0.5 * math.pi,
        arcSweep = value != null ? clampDouble(value, 0.0, 1.0) * paintingCircularProgressSweep : math.max(headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi, epsilon);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, paintingCircularProgressSweep, false, backgroundPaint);
    }

    paint.strokeCap = strokeCap;

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(CircularProgressIndicatorPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.valueColor != valueColor ||
      oldDelegate.value != value ||
      oldDelegate.headValue != headValue ||
      oldDelegate.tailValue != tailValue ||
      oldDelegate.offsetValue != offsetValue ||
      oldDelegate.rotationValue != rotationValue ||
      oldDelegate.strokeCap != strokeCap ||
      oldDelegate.strokeWidth != strokeWidth;
}
