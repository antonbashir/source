import 'package:design/painters/toggleable/toggleable.dart';
import 'package:flutter/widgets.dart';

class CheckboxPainter extends ToggleablePainter {
  final double size;
  final double strokeWidth;

  CheckboxPainter({required this.size, required this.strokeWidth});

  Color get checkColor => _checkColor!;
  Color? _checkColor;
  set checkColor(Color value) {
    if (_checkColor == value) return;
    _checkColor = value;
    notifyListeners();
  }

  bool? get value => _value;
  bool? _value;
  set value(bool? value) {
    if (_value == value) return;
    _value = value;
    notifyListeners();
  }

  bool? get previousValue => _previousValue;
  bool? _previousValue;
  set previousValue(bool? value) {
    if (_previousValue == value) return;
    _previousValue = value;
    notifyListeners();
  }

  OutlinedBorder get shape => _shape!;
  OutlinedBorder? _shape;
  set shape(OutlinedBorder value) {
    if (_shape == value) return;
    _shape = value;
    notifyListeners();
  }

  BorderSide? get side => _side;
  BorderSide? _side;
  set side(BorderSide? value) {
    if (_side == value) return;
    _side = value;
    notifyListeners();
  }

  Rect _outerRectAt(Offset origin, double t) => Rect.fromLTWH(origin.dx, origin.dy, size, size);

  Color _colorAt(double t) => t >= 0.25 ? activeColor : Color.lerp(inactiveColor, activeColor, t * 4.0)!;

  Paint _createStrokePaint() => Paint()
    ..color = checkColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;

  void _drawBox(Canvas canvas, Rect outer, Paint paint, BorderSide? side, bool fill) {
    if (fill) canvas.drawPath(shape.getOuterPath(outer), paint);
    if (side != null) shape.copyWith(side: side).paint(canvas, outer);
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    final path = Path();

    final start = Offset(size * 0.15, size * 0.45);
    final mid = Offset(size * 0.4, size * 0.7);
    final end = Offset(size * 0.85, size * 0.25);

    if (t < 0.5) {
      final strokeT = t * 2.0;
      final drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
      canvas.drawPath(path, paint);
      return;
    }

    final strokeT = (t - 0.5) * 2.0;
    final drawEnd = Offset.lerp(mid, end, strokeT)!;
    path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
    path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
    path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    canvas.drawPath(path, paint);
  }

  void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
    final start = Offset(size * 0.2, size * 0.5);
    final mid = Offset(size * 0.5, size * 0.5);
    final end = Offset(size * 0.8, size * 0.5);
    final drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final drawEnd = Offset.lerp(mid, end, t)!;

    canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = _createStrokePaint();
    final origin = size / 2.0 - Size.square(this.size) / 2.0 as Offset;
    final status = position.status;
    final tNormalized = status == AnimationStatus.forward || status == AnimationStatus.completed ? position.value : 1.0 - position.value;

    if (previousValue == false || value == false) {
      final t = value == false ? 1.0 - tNormalized : tNormalized;
      final outer = _outerRectAt(origin, t);
      final paint = Paint()..color = _colorAt(t);

      if (t <= 0.5) {
        final border = side ?? BorderSide(color: paint.color);
        _drawBox(canvas, outer, paint, border, true);
        return;
      }

      _drawBox(canvas, outer, paint, side, true);
      final tShrink = (t - 0.5) * 2.0;
      if (previousValue == null || value == null) {
        _drawDash(canvas, origin, tShrink, strokePaint);
        return;
      }
      _drawCheck(canvas, origin, tShrink, strokePaint);
      return;
    }

    final outer = _outerRectAt(origin, 1.0);
    final paint = Paint()..color = _colorAt(1.0);
    _drawBox(canvas, outer, paint, side, true);

    if (tNormalized <= 0.5) {
      final double tShrink = 1.0 - tNormalized * 2.0;
      if (previousValue ?? false) {
        _drawCheck(canvas, origin, tShrink, strokePaint);
        return;
      }
      _drawDash(canvas, origin, tShrink, strokePaint);
      return;
    }

    final tExpand = (tNormalized - 0.5) * 2.0;
    if (value ?? false) {
      _drawCheck(canvas, origin, tExpand, strokePaint);
      return;
    }
    _drawDash(canvas, origin, tExpand, strokePaint);
  }
}
