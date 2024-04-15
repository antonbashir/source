import 'package:design/painters/toggleable/toggleable.dart';
import 'package:flutter/widgets.dart';

class RadioPainter extends ToggleablePainter {
  final double innerRadius;
  final double outerRadius;

  RadioPainter({required this.innerRadius, required this.outerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;

    final Paint paint = Paint()
      ..color = Color.lerp(inactiveColor, activeColor, position.value)!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, outerRadius, paint);

    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;

      canvas.drawCircle(center, innerRadius * position.value, paint);
    }
  }
}
