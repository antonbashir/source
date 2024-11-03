import 'package:flutter/widgets.dart';

class ProgressPinPainter extends CustomPainter {
  final bool showShadow;
  final Color pinColor;
  final Color thumbColor;
  final Color shadowColor;
  final Color pinBorderColor;
  final double arrowHeight;
  final double arrowWidth;
  final double pinBorderWidth;
  final double pinDistance;
  final double pinWidth;
  final double? thumbSizeValue;
  final double progressValue;
  final double shadowElevation;
  final String pinText;
  final TextStyle textStyle;
  final TextDirection textDirection;

  const ProgressPinPainter({
    required this.showShadow,
    required this.pinColor,
    required this.thumbColor,
    required this.shadowColor,
    required this.pinBorderColor,
    required this.pinBorderWidth,
    required this.arrowHeight,
    required this.arrowWidth,
    required this.pinDistance,
    required this.pinWidth,
    this.thumbSizeValue,
    required this.progressValue,
    required this.shadowElevation,
    required this.pinText,
    required this.textStyle,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = pinWidth / 2;
    final double thumbRadius = switch (thumbSizeValue) {
      _ when thumbSizeValue != null => thumbSizeValue! / 2,
      _ => size.height / 2,
    };
    final double offsetY = -(radius + arrowHeight + pinDistance) + (size.height / 2 - thumbRadius);

    double offsetX = switch (textDirection) {
      TextDirection.rtl => size.width - progressValue * size.width,
      TextDirection.ltr => progressValue * size.width,
    };

    final outerCirclePaint = Paint()..color = pinBorderColor;
    final innerCirclePaint = Paint()..color = pinColor;
    final thumbCirclePaint = Paint()..color = thumbColor;

    final Path path = Path()
      ..addOval(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius))
      ..addOval(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius))
      ..moveTo(offsetX - arrowWidth / 2, offsetY + radius - 0.5)
      ..lineTo(offsetX, offsetY + radius + arrowHeight)
      ..lineTo(offsetX + arrowWidth / 2, offsetY + radius - 0.5)
      ..close();

    if (showShadow) canvas.drawShadow(path, shadowColor, shadowElevation, false);
    canvas.drawPath(path, outerCirclePaint);
    canvas.drawCircle(Offset(offsetX, offsetY), radius - pinBorderWidth, innerCirclePaint);
    canvas.drawCircle(Offset(offsetX, size.height / 2), thumbRadius, thumbCirclePaint);

    final TextPainter pinTextPainter = TextPainter(
      text: TextSpan(text: pinText, style: textStyle),
      textDirection: textDirection,
    );

    pinTextPainter.layout();
    pinTextPainter.paint(canvas, Offset(offsetX - pinTextPainter.width / 2, offsetY - pinTextPainter.height / 2));
  }

  @override
  bool shouldRepaint(ProgressPinPainter oldDelegate) =>
      oldDelegate.progressValue != progressValue ||
      oldDelegate.pinWidth != pinWidth ||
      oldDelegate.pinBorderWidth != pinBorderWidth ||
      oldDelegate.pinColor != pinColor ||
      oldDelegate.pinBorderColor != pinBorderColor ||
      oldDelegate.pinDistance != pinDistance ||
      oldDelegate.thumbColor != thumbColor ||
      oldDelegate.thumbSizeValue != thumbSizeValue ||
      oldDelegate.showShadow != showShadow ||
      oldDelegate.shadowColor != shadowColor ||
      oldDelegate.shadowElevation != shadowElevation ||
      oldDelegate.textDirection != textDirection;
}
