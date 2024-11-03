import 'package:design/borders/squircle/radius.dart';
import 'package:flutter/widgets.dart';

class FocusEffectPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isFilled;
  final BorderRadius borderRadius;
  final Color color;
  final double effectExtent;

  FocusEffectPainter({
    required this.animation,
    required this.borderRadius,
    this.isFilled = false,
    required this.color,
    required this.effectExtent,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (!animation.isDismissed) {
      final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final transformedColor = Color.lerp(null, color, animation.value)!;
      final newWidth = rect.width + effectExtent;
      final newHeight = rect.height + effectExtent;
      final widthIncrease = newWidth / rect.width;
      final heightIncrease = newHeight / rect.height;
      final widthOffset = (widthIncrease - 1) / 2;
      final heightOffset = (heightIncrease - 1) / 2;
      final resolvedExtent = borderRadius != BorderRadius.zero ? (effectExtent / 2) : 0;

      final paint = isFilled
          ? (Paint()
            ..color = transformedColor
            ..style = PaintingStyle.fill)
          : (Paint()
            ..color = transformedColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = effectExtent + 1);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          topLeft: SquircleRadius(cornerRadius: borderRadius.topLeft.x + resolvedExtent),
          topRight: SquircleRadius(cornerRadius: borderRadius.topRight.x + resolvedExtent),
          bottomLeft: SquircleRadius(cornerRadius: borderRadius.bottomLeft.x + resolvedExtent),
          bottomRight: SquircleRadius(cornerRadius: borderRadius.bottomRight.x + resolvedExtent),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FocusEffectPainter oldDelegate) => animation != oldDelegate.animation || color != oldDelegate.color;
}
