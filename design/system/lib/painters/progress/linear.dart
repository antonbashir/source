import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/progresses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class LinearProgressIndicatorPainter extends CustomPainter {
  final double? value;
  final Color backgroundColor;
  final Color valueColor;
  final double animationValue;
  final BorderRadius containerRadius;
  final BorderRadius progressRadius;
  final TextDirection textDirection;

  const LinearProgressIndicatorPainter({
    required this.backgroundColor,
    required this.valueColor,
    this.value,
    required this.animationValue,
    required this.containerRadius,
    required this.progressRadius,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final containerRect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: SquircleRadius(cornerRadius: containerRadius.topLeft.x),
      topRight: SquircleRadius(cornerRadius: containerRadius.topRight.x),
      bottomLeft: SquircleRadius(cornerRadius: containerRadius.bottomLeft.x),
      bottomRight: SquircleRadius(cornerRadius: containerRadius.bottomRight.x),
    );
    canvas.drawRRect(containerRect, paint);

    paint.color = valueColor;

    void drawBar(double x, double width) {
      if (width <= 0.0) return;

      final left = switch (textDirection) {
        TextDirection.rtl => size.width - width - x,
        TextDirection.ltr => x,
      };

      final progressRect = RRect.fromRectAndCorners(
        Offset(left, 0.0) & Size(width, size.height),
        topLeft: SquircleRadius(cornerRadius: progressRadius.topLeft.x),
        topRight: SquircleRadius(cornerRadius: progressRadius.topRight.x),
        bottomLeft: SquircleRadius(cornerRadius: progressRadius.bottomLeft.x),
        bottomRight: SquircleRadius(cornerRadius: progressRadius.bottomRight.x),
      );

      canvas.clipRRect(containerRect);
      canvas.drawRRect(progressRect, paint);
    }

    if (value != null) {
      drawBar(0.0, clampDouble(value!, 0.0, 1.0) * size.width);
      return;
    }

    final x1 = size.width * paintingLinearProgressLine1Tail.transform(animationValue);
    final width1 = size.width * paintingLinearProgressLine1Head.transform(animationValue) - x1;

    final x2 = size.width * paintingLinearProgressLine2Tail.transform(animationValue);
    final width2 = size.width * paintingLinearProgressLine2Head.transform(animationValue) - x2;

    drawBar(x1, width1);
    drawBar(x2, width2);
  }

  @override
  bool shouldRepaint(LinearProgressIndicatorPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.valueColor != valueColor ||
      oldDelegate.value != value ||
      oldDelegate.animationValue != animationValue ||
      oldDelegate.containerRadius != containerRadius ||
      oldDelegate.progressRadius != progressRadius ||
      oldDelegate.textDirection != textDirection;
}
