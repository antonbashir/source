import 'dart:math';
import 'dart:ui';

import 'package:design/borders/squircle/border_radius.dart';
import 'package:design/borders/squircle/radius.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum SquircleBorderAlign {
  inside,
  center,
  outside,
}

class SquircleBorder extends OutlinedBorder {
  final SquircleBorderRadius borderRadius;
  final SquircleBorderAlign borderAlign;

  const SquircleBorder({
    super.side = SquircleBorderSide.none,
    this.borderRadius = SquircleBorderRadius.zero,
    this.borderAlign = SquircleBorderAlign.inside,
  });

  @override
  EdgeInsetsGeometry get dimensions =>
      switch (borderAlign) { SquircleBorderAlign.inside => EdgeInsets.zero, SquircleBorderAlign.center => EdgeInsets.zero, SquircleBorderAlign.outside => EdgeInsets.zero };

  @override
  ShapeBorder scale(double t) => SquircleBorder(
        side: side.scale(t),
        borderRadius: borderRadius * t,
      );

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SquircleBorder) {
      return SquircleBorder(
        side: SquircleBorderSide.lerp(a.side, side, t),
        borderRadius: SquircleBorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SquircleBorder) {
      return SquircleBorder(
        side: SquircleBorderSide.lerp(side, b.side, t),
        borderRadius: SquircleBorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = switch (borderAlign) {
      SquircleBorderAlign.inside => rect.deflate(side.width),
      SquircleBorderAlign.center => rect.deflate(side.width / 2),
      SquircleBorderAlign.outside => rect,
    };

    final radius = switch (borderAlign) {
      SquircleBorderAlign.inside => -SquircleBorderRadius.all(
          SquircleRadius(
            cornerRadius: side.width,
          ),
        ),
      SquircleBorderAlign.center => borderRadius -
          SquircleBorderRadius.all(
            SquircleRadius(
              cornerRadius: side.width / 2,
            ),
          ),
      SquircleBorderAlign.outside => borderRadius
    };

    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight].every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(innerRect));
    }

    return radius.toPath(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => _getPath(rect, borderRadius, textDirection: textDirection);

  Path _getPath(Rect rect, SquircleBorderRadius radius, {TextDirection? textDirection}) {
    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight].every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(rect));
    }

    return radius.toPath(rect);
  }

  @override
  SquircleBorder copyWith({
    BorderSide? side,
    SquircleBorderRadius? borderRadius,
    SquircleBorderAlign? borderAlign,
  }) =>
      SquircleBorder(
        side: side ?? this.side,
        borderRadius: borderRadius ?? this.borderRadius,
        borderAlign: borderAlign ?? this.borderAlign,
      );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final adjustedRect = switch (borderAlign) {
          SquircleBorderAlign.inside => rect.deflate(side.width / 2),
          SquircleBorderAlign.center => rect,
          SquircleBorderAlign.outside => rect.inflate(side.width / 2),
        };

        final adjustedBorderRadius = switch (borderAlign) {
          SquircleBorderAlign.inside => borderRadius - SquircleBorderRadius.all(SquircleRadius(cornerRadius: side.width / 2)),
          SquircleBorderAlign.center => borderRadius,
          SquircleBorderAlign.outside => borderRadius + SquircleBorderRadius.all(SquircleRadius(cornerRadius: side.width / 2))
        };

        final outerPath = _getPath(
          adjustedRect,
          adjustedBorderRadius,
          textDirection: textDirection,
        );

        canvas.drawPath(outerPath, side.toPaint());
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SquircleBorder && other.side == side && other.borderRadius == borderRadius && other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius, borderAlign);
}

class SquircleBorderSide with Diagnosticable {
  static const double strokeAlignInside = -1.0;
  static const double strokeAlignCenter = 0.0;
  static const double strokeAlignOutside = 1.0;

  static BorderSide merge(BorderSide a, BorderSide b) {
    assert(canMerge(a, b));
    final bool aIsNone = a.style == BorderStyle.none && a.width == 0.0;
    final bool bIsNone = b.style == BorderStyle.none && b.width == 0.0;
    if (aIsNone && bIsNone) {
      return BorderSide.none;
    }
    if (aIsNone) {
      return b;
    }
    if (bIsNone) {
      return a;
    }
    assert(a.color == b.color);
    assert(a.style == b.style);
    return BorderSide(
      color: a.color,
      width: a.width + b.width,
      strokeAlign: max(a.strokeAlign, b.strokeAlign),
      style: a.style,
    );
  }

  final Color color;
  final double width;
  final BorderStyle style;
  static const BorderSide none = BorderSide.none;
  final double strokeAlign;

  const SquircleBorderSide({
    this.color = const Color(0xFF000000),
    this.width = 1.0,
    this.style = BorderStyle.solid,
    this.strokeAlign = strokeAlignInside,
  }) : assert(width >= 0.0);

  BorderSide copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return BorderSide(
      color: color ?? this.color,
      width: width ?? this.width,
      style: style ?? this.style,
      strokeAlign: strokeAlign ?? this.strokeAlign,
    );
  }

  BorderSide scale(double t) {
    return BorderSide(
      color: color,
      width: max(0.0, width * t),
      style: t <= 0.0 ? BorderStyle.none : style,
    );
  }

  Paint toPaint() => switch (style) {
        BorderStyle.solid => Paint()
          ..color = color
          ..strokeWidth = width
          ..style = PaintingStyle.stroke,
        BorderStyle.none => Paint()
          ..color = const Color(0x00000000)
          ..strokeWidth = 0.0
          ..style = PaintingStyle.stroke
      };

  static bool canMerge(BorderSide a, BorderSide b) {
    if ((a.style == BorderStyle.none && a.width == 0.0) || (b.style == BorderStyle.none && b.width == 0.0)) {
      return true;
    }
    return a.style == b.style && a.color == b.color;
  }

  static BorderSide lerp(BorderSide a, BorderSide b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    final double width = lerpDouble(a.width, b.width, t)!;
    if (width < 0.0) {
      return BorderSide.none;
    }
    if (a.style == b.style && a.strokeAlign == b.strokeAlign) {
      return BorderSide(
        color: Color.lerp(a.color, b.color, t)!,
        width: width,
        style: a.style,
        strokeAlign: a.strokeAlign,
      );
    }
    final Color colorA;
    final Color colorB;
    switch (a.style) {
      case BorderStyle.solid:
        colorA = a.color;
      case BorderStyle.none:
        colorA = a.color.withAlpha(0x00);
    }
    switch (b.style) {
      case BorderStyle.solid:
        colorB = b.color;
      case BorderStyle.none:
        colorB = b.color.withAlpha(0x00);
    }
    if (a.strokeAlign != b.strokeAlign) {
      return BorderSide(
        color: Color.lerp(colorA, colorB, t)!,
        width: width,
        strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t)!,
      );
    }
    return BorderSide(
      color: Color.lerp(colorA, colorB, t)!,
      width: width,
      strokeAlign: a.strokeAlign,
    );
  }

  double get strokeInset => width * (1 - (1 + strokeAlign) / 2);
  double get strokeOutset => width * (1 + strokeAlign) / 2;
  double get strokeOffset => width * strokeAlign;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BorderSide && other.color == color && other.width == width && other.style == style && other.strokeAlign == strokeAlign;
  }

  @override
  int get hashCode => Object.hash(color, width, style, strokeAlign);
}
