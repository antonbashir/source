// ignore_for_file: overridden_fields, unused_element

import 'package:design/borders/squircle/corners.dart';
import 'package:design/borders/squircle/processed.dart';
import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/squircle.dart';
import 'package:flutter/rendering.dart';

class SquircleBorderRadius extends BorderRadius {
  static const SquircleBorderRadius zero = SquircleBorderRadius.all(SquircleRadius.zero);

  @override
  final SquircleRadius topLeft;

  @override
  final SquircleRadius topRight;

  @override
  final SquircleRadius bottomLeft;

  @override
  final SquircleRadius bottomRight;

  Radius get _topLeft => topLeft;
  Radius get _topRight => topRight;
  Radius get _bottomLeft => bottomLeft;
  Radius get _bottomRight => bottomRight;
  Radius get _topStart => Radius.zero;
  Radius get _topEnd => Radius.zero;
  Radius get _bottomStart => Radius.zero;
  Radius get _bottomEnd => Radius.zero;

  SquircleBorderRadius({required double cornerRadius, double cornerSmoothing = squircleSmoothing})
      : this.only(
          topLeft: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          topRight: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomLeft: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomRight: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
        );

  const SquircleBorderRadius.all(SquircleRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  const SquircleBorderRadius.vertical({SquircleRadius top = SquircleRadius.zero, SquircleRadius bottom = SquircleRadius.zero})
      : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  const SquircleBorderRadius.horizontal({SquircleRadius left = SquircleRadius.zero, SquircleRadius right = SquircleRadius.zero})
      : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  const SquircleBorderRadius.only({
    this.topLeft = SquircleRadius.zero,
    this.topRight = SquircleRadius.zero,
    this.bottomLeft = SquircleRadius.zero,
    this.bottomRight = SquircleRadius.zero,
  }) : super.only(
          topLeft: topLeft,
          bottomRight: topRight,
          topRight: topRight,
          bottomLeft: bottomLeft,
        );

  @override
  SquircleBorderRadius copyWith({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) =>
      SquircleBorderRadius.only(
        topLeft: topLeft is SquircleRadius ? topLeft : this.topLeft,
        topRight: topRight is SquircleRadius ? topRight : this.topRight,
        bottomLeft: bottomLeft is SquircleRadius ? bottomLeft : this.bottomLeft,
        bottomRight: bottomRight is SquircleRadius ? bottomRight : this.bottomRight,
      );

  Path toPath(Rect rect) {
    final width = rect.width;
    final height = rect.height;

    final result = Path();

    final processedTopLeft = ProcessedSquircleRadius(
      topLeft,
      width: width,
      height: height,
    );

    final processedBottomLeft = topLeft == bottomLeft
        ? processedTopLeft
        : ProcessedSquircleRadius(
            bottomLeft,
            width: width,
            height: height,
          );

    final processedBottomRight = bottomLeft == bottomRight
        ? processedBottomLeft
        : ProcessedSquircleRadius(
            bottomRight,
            width: width,
            height: height,
          );

    final processedTopRight = topRight == bottomRight
        ? processedBottomRight
        : ProcessedSquircleRadius(
            topRight,
            width: width,
            height: height,
          );

    result
      ..addSmoothTopRight(processedTopRight, rect)
      ..addSmoothBottomRight(processedBottomRight, rect)
      ..addSmoothBottomLeft(processedBottomLeft, rect)
      ..addSmoothTopLeft(processedTopLeft, rect);

    return result.transform(
      Matrix4.translationValues(rect.left, rect.top, 0).storage,
    );
  }

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) {
    if (other is SquircleBorderRadius) return this - other;
    return super.subtract(other);
  }

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) {
    if (other is SquircleBorderRadius) return this + other;
    return super.add(other);
  }

  @override
  SquircleBorderRadius operator -(BorderRadius other) {
    if (other is SquircleBorderRadius) {
      return SquircleBorderRadius.only(
        topLeft: (topLeft - other.topLeft) as SquircleRadius,
        topRight: (topRight - other.topRight) as SquircleRadius,
        bottomLeft: (bottomLeft - other.bottomLeft) as SquircleRadius,
        bottomRight: (bottomRight - other.bottomRight) as SquircleRadius,
      );
    }

    return this;
  }

  @override
  SquircleBorderRadius operator +(BorderRadius other) {
    if (other is SquircleBorderRadius) {
      return SquircleBorderRadius.only(
        topLeft: (topLeft + other.topLeft) as SquircleRadius,
        topRight: (topRight + other.topRight) as SquircleRadius,
        bottomLeft: (bottomLeft + other.bottomLeft) as SquircleRadius,
        bottomRight: (bottomRight + other.bottomRight) as SquircleRadius,
      );
    }

    return this;
  }

  @override
  SquircleBorderRadius operator -() => SquircleBorderRadius.only(
        topLeft: (-topLeft) as SquircleRadius,
        topRight: (-topRight) as SquircleRadius,
        bottomLeft: (-bottomLeft) as SquircleRadius,
        bottomRight: (-bottomRight) as SquircleRadius,
      );

  @override
  SquircleBorderRadius operator *(double other) => SquircleBorderRadius.only(
        topLeft: topLeft * other,
        topRight: topRight * other,
        bottomLeft: bottomLeft * other,
        bottomRight: bottomRight * other,
      );

  @override
  SquircleBorderRadius operator /(double other) => SquircleBorderRadius.only(
        topLeft: topLeft / other,
        topRight: topRight / other,
        bottomLeft: bottomLeft / other,
        bottomRight: bottomRight / other,
      );

  @override
  SquircleBorderRadius operator ~/(double other) => SquircleBorderRadius.only(
        topLeft: topLeft ~/ other,
        topRight: topRight ~/ other,
        bottomLeft: bottomLeft ~/ other,
        bottomRight: bottomRight ~/ other,
      );

  @override
  SquircleBorderRadius operator %(double other) => SquircleBorderRadius.only(
        topLeft: topLeft % other,
        topRight: topRight % other,
        bottomLeft: bottomLeft % other,
        bottomRight: bottomRight % other,
      );

  static SquircleBorderRadius? lerp(SquircleBorderRadius? a, SquircleBorderRadius? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return SquircleBorderRadius.only(
      topLeft: SquircleRadius.lerp(a.topLeft, b.topLeft, t)!,
      topRight: SquircleRadius.lerp(a.topRight, b.topRight, t)!,
      bottomLeft: SquircleRadius.lerp(a.bottomLeft, b.bottomLeft, t)!,
      bottomRight: SquircleRadius.lerp(a.bottomRight, b.bottomRight, t)!,
    );
  }

  @override
  BorderRadius resolve(TextDirection? direction) => BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      );
}
