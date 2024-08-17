import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:design/constants/borders.dart';
import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/widgets.dart';

abstract class InputBorder extends ShapeBorder {
  const InputBorder({this.borderSide = BorderSide.none});

  static const InputBorder none = _NoInputBorder();
  final BorderSide borderSide;

  InputBorder copyWith({BorderSide? borderSide});

  bool get isOutline;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  });
}

class _NoInputBorder extends InputBorder {
  const _NoInputBorder() : super(borderSide: BorderSide.none);

  @override
  _NoInputBorder copyWith({BorderSide? borderSide}) => const _NoInputBorder();

  @override
  bool get isOutline => false;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  _NoInputBorder scale(double t) => const _NoInputBorder();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(rect);

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection}) => canvas.drawRect(rect, paint);

  @override
  bool get preferPaintInterior => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {}
}

class UnderlineInputBorder extends InputBorder {
  const UnderlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: defaultBorderRadius,
      topRight: defaultBorderRadius,
    ),
  });

  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  UnderlineInputBorder copyWith({BorderSide? borderSide, BorderRadius? borderRadius}) => UnderlineInputBorder(
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: borderSide.width);

  @override
  UnderlineInputBorder scale(double t) => UnderlineInputBorder(borderSide: borderSide.scale(t));

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(Rect.fromLTWH(rect.left, rect.top, rect.width, math.max(0.0, rect.height - borderSide.width)));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection}) => canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);

  @override
  bool get preferPaintInterior => true;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is UnderlineInputBorder) {
      return UnderlineInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is UnderlineInputBorder) {
      return UnderlineInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    if (borderRadius.bottomLeft != Radius.zero || borderRadius.bottomRight != Radius.zero) {
      final BorderRadius updatedBorderRadius = BorderRadius.only(
        bottomLeft: borderRadius.bottomLeft.clamp(maximum: Radius.circular(rect.height / 2)),
        bottomRight: borderRadius.bottomRight.clamp(maximum: Radius.circular(rect.height / 2)),
      );

      BoxBorder.paintNonUniformBorder(
        canvas,
        rect,
        textDirection: textDirection,
        borderRadius: updatedBorderRadius,
        bottom: borderSide.copyWith(strokeAlign: BorderSide.strokeAlignCenter),
        color: borderSide.color,
      );
      return;
    }
    canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is UnderlineInputBorder && other.borderSide == borderSide && other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius);
}

class OutlineInputBorder extends InputBorder {
  const OutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(defaultBorderRadius),
    this.gapPadding = defaultGapPadding,
  }) : assert(gapPadding >= 0.0);

  static bool _cornersAreCircular(BorderRadius borderRadius) =>
      borderRadius.topLeft.x == borderRadius.topLeft.y &&
      borderRadius.bottomLeft.x == borderRadius.bottomLeft.y &&
      borderRadius.topRight.x == borderRadius.topRight.y &&
      borderRadius.bottomRight.x == borderRadius.bottomRight.y;

  final double gapPadding;
  final BorderRadius borderRadius;

  @override
  bool get isOutline => true;

  @override
  OutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
  }) =>
      OutlineInputBorder(
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius,
        gapPadding: gapPadding ?? this.gapPadding,
      );

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderSide.width);

  @override
  OutlineInputBorder scale(double t) => OutlineInputBorder(
        borderSide: borderSide.scale(t),
        borderRadius: borderRadius * t,
        gapPadding: gapPadding * t,
      );

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is OutlineInputBorder) {
      final OutlineInputBorder outline = a;
      return OutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is OutlineInputBorder) {
      final OutlineInputBorder outline = b;
      return OutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(borderSide.width));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection}) {
    canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  Path _gapBorderPath(Canvas canvas, RRect center, double start, double extent) {
    final scaledRRect = center.scaleRadii();

    final tlCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.top,
      scaledRRect.tlRadiusX * 2.0,
      scaledRRect.tlRadiusY * 2.0,
    );

    final trCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.trRadiusX * 2.0,
      scaledRRect.top,
      scaledRRect.trRadiusX * 2.0,
      scaledRRect.trRadiusY * 2.0,
    );

    final brCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.brRadiusX * 2.0,
      scaledRRect.bottom - scaledRRect.brRadiusY * 2.0,
      scaledRRect.brRadiusX * 2.0,
      scaledRRect.brRadiusY * 2.0,
    );

    final blCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.bottom - scaledRRect.blRadiusY * 2.0,
      scaledRRect.blRadiusX * 2.0,
      scaledRRect.blRadiusY * 2.0,
    );

    const cornerArcSweep = math.pi / 2.0;
    final path = Path();

    if (scaledRRect.tlRadius != Radius.zero) {
      final double tlCornerArcSweep = math.acos(clampDouble(1 - start / scaledRRect.tlRadiusX, 0.0, 1.0));
      path.addArc(tlCorner, math.pi, tlCornerArcSweep);
    } else {
      path.moveTo(scaledRRect.left - borderSide.width / 2, scaledRRect.top);
    }

    if (start > scaledRRect.tlRadiusX) {
      path.lineTo(scaledRRect.left + start, scaledRRect.top);
    }

    const double trCornerArcStart = (3 * math.pi) / 2.0;
    const double trCornerArcSweep = cornerArcSweep;
    if (start + extent < scaledRRect.width - scaledRRect.trRadiusX) {
      path.moveTo(scaledRRect.left + start + extent, scaledRRect.top);
      path.lineTo(scaledRRect.right - scaledRRect.trRadiusX, scaledRRect.top);
      if (scaledRRect.trRadius != Radius.zero) {
        path.addArc(trCorner, trCornerArcStart, trCornerArcSweep);
      }
    } else if (start + extent < scaledRRect.width) {
      final double dx = scaledRRect.width - (start + extent);
      final double sweep = math.asin(clampDouble(1 - dx / scaledRRect.trRadiusX, 0.0, 1.0));
      path.addArc(trCorner, trCornerArcStart + sweep, trCornerArcSweep - sweep);
    }

    if (scaledRRect.brRadius != Radius.zero) {
      path.moveTo(scaledRRect.right, scaledRRect.top + scaledRRect.trRadiusY);
    }
    path.lineTo(scaledRRect.right, scaledRRect.bottom - scaledRRect.brRadiusY);
    if (scaledRRect.brRadius != Radius.zero) {
      path.addArc(brCorner, 0.0, cornerArcSweep);
    }

    path.lineTo(scaledRRect.left + scaledRRect.blRadiusX, scaledRRect.bottom);
    if (scaledRRect.blRadius != Radius.zero) {
      path.addArc(blCorner, math.pi / 2.0, cornerArcSweep);
    }

    path.lineTo(scaledRRect.left, scaledRRect.top + scaledRRect.tlRadiusY);

    return path;
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    assert(_cornersAreCircular(borderRadius));

    final Paint paint = borderSide.toPaint();
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    if (gapStart == null || gapExtent <= 0.0 || gapPercentage == 0.0) {
      canvas.drawRRect(center, paint);
      return;
    }
    final double extent = lerpDouble(0.0, gapExtent + gapPadding * 2.0, gapPercentage)!;
    switch (textDirection!) {
      case TextDirection.rtl:
        final Path path = _gapBorderPath(canvas, center, math.max(0.0, gapStart + gapPadding - extent), extent);
        canvas.drawPath(path, paint);

      case TextDirection.ltr:
        final Path path = _gapBorderPath(canvas, center, math.max(0.0, gapStart - gapPadding), extent);
        canvas.drawPath(path, paint);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OutlineInputBorder && other.borderSide == borderSide && other.borderRadius == borderRadius && other.gapPadding == gapPadding;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding);
}
