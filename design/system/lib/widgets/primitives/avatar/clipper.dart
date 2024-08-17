import 'package:design/borders/squircle/radius.dart';
import 'package:design/constants/avatar.dart';
import 'package:flutter/rendering.dart';

class AvatarClipper extends CustomClipper<Path> {
  final bool showBadge;
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final double badgeMarginValue;
  final double badgeSize;
  final AvatarBadgeAlignment badgeAlignment;
  final TextDirection textDirection;

  AvatarClipper({
    required this.showBadge,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.badgeMarginValue,
    required this.badgeSize,
    required this.badgeAlignment,
    required this.textDirection,
  });

  Path _getBadgePath() {
    final double badgeRadius = badgeSize / 2;

    if (textDirection == TextDirection.rtl) {
      return switch (badgeAlignment) {
        AvatarBadgeAlignment.topLeft => Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(width - badgeRadius, 0 + badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          ),
        AvatarBadgeAlignment.topRight => Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(0 + badgeRadius, 0 + badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          ),
        AvatarBadgeAlignment.bottomLeft => Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(width - badgeRadius, width - badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          ),
        AvatarBadgeAlignment.bottomRight => Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(0 + badgeRadius, width - badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          ),
        _ => Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(width - badgeRadius, width - badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          )
      };
    }

    return switch (badgeAlignment) {
      AvatarBadgeAlignment.topLeft => Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(0 + badgeRadius, 0 + badgeRadius),
            radius: badgeRadius + badgeMarginValue,
          ),
        ),
      AvatarBadgeAlignment.topRight => Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(width - badgeRadius, 0 + badgeRadius),
            radius: badgeRadius + badgeMarginValue,
          ),
        ),
      AvatarBadgeAlignment.bottomLeft => Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(0 + badgeRadius, height - badgeRadius),
            radius: badgeRadius + badgeMarginValue,
          ),
        ),
      AvatarBadgeAlignment.bottomRight => Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(width - badgeRadius, height - badgeRadius),
            radius: badgeRadius + badgeMarginValue,
          ),
        ),
    };
  }

  @override
  Path getClip(Size size) {
    final Path pathWithBadge = Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            width,
            height,
            topLeft: SquircleRadius(cornerRadius: borderRadius.topLeft.x),
            topRight: SquircleRadius(cornerRadius: borderRadius.topRight.x),
            bottomLeft: SquircleRadius(cornerRadius: borderRadius.bottomLeft.x),
            bottomRight: SquircleRadius(cornerRadius: borderRadius.bottomRight.x),
          ),
        ),
      _getBadgePath(),
    );

    final Path pathWithoutBadge = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width,
          height,
          topLeft: SquircleRadius(cornerRadius: borderRadius.topLeft.x),
          topRight: SquircleRadius(cornerRadius: borderRadius.topRight.x),
          bottomLeft: SquircleRadius(cornerRadius: borderRadius.bottomLeft.x),
          bottomRight: SquircleRadius(cornerRadius: borderRadius.bottomRight.x),
        ),
      );

    return showBadge ? pathWithBadge : pathWithoutBadge;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
