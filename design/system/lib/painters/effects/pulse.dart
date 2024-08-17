import 'dart:ui';

import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class PulseEffectPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double effectExtent;
  final BorderRadius borderRadius;

  PulseEffectPainter({
    required this.color,
    required this.animation,
    required this.effectExtent,
    required this.borderRadius,
  }) : super(repaint: animation);

  double animationRange({
    required double begin,
    required double end,
    required double animationValue,
  }) =>
      clampDouble((animationValue - begin) / (end - begin), 0.0, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    if (!animation.isDismissed) {
      final rangeValue = animationRange(begin: pulseAnimationRangeStartValue, end: 1.0, animationValue: animation.value);
      final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final opacity = (rangeValue == 0.0 ? 0.0 : 1.0 - rangeValue).clamp(0.0, 1.0);
      final transformedColor = color.withOpacity(opacity);
      final newWidth = rect.width + rangeValue * effectExtent;
      final newHeight = rect.height + rangeValue * effectExtent;
      final widthIncrease = newWidth / rect.width;
      final heightIncrease = newHeight / rect.height;
      final widthOffset = (widthIncrease - 1) / 2;
      final heightOffset = (heightIncrease - 1) / 2;
      final resolvedExtent = borderRadius != BorderRadius.zero ? (effectExtent / 2) : 0;
      final topLeftLerp = lerpDouble(borderRadius.topLeft.x, borderRadius.topLeft.x + resolvedExtent, rangeValue)!;
      final topRightLerp = lerpDouble(borderRadius.topRight.x, borderRadius.topRight.x + resolvedExtent, rangeValue)!;
      final bottomLeftLerp = lerpDouble(borderRadius.bottomLeft.x, borderRadius.bottomLeft.x + resolvedExtent, rangeValue)!;
      final bottomRightLerp = lerpDouble(borderRadius.bottomRight.x, borderRadius.bottomRight.x + resolvedExtent, rangeValue)!;

      final paint = Paint()
        ..color = transformedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = rangeValue * effectExtent + 1;

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          topLeft: SquircleRadius(cornerRadius: topLeftLerp),
          topRight: SquircleRadius(cornerRadius: topRightLerp),
          bottomLeft: SquircleRadius(cornerRadius: bottomLeftLerp),
          bottomRight: SquircleRadius(cornerRadius: bottomRightLerp),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PulseEffectPainter oldDelegate) => false;
}
