import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/avatar.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/avatar/clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Avatar extends StatelessWidget {
  final bool showBadge;
  final AvatarBadgeAlignment badgeAlignment;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? badgeColor;
  final double? badgeMarginValue;
  final double? badgeSize;
  final double? height;
  final double? width;
  final ImageProvider<Object>? backgroundImage;
  final BreakpointSize? size;
  final String? semanticLabel;
  final Widget? content;

  const Avatar({
    super.key,
    this.showBadge = false,
    this.badgeAlignment = AvatarBadgeAlignment.bottomRight,
    this.borderType,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.badgeColor,
    this.badgeMarginValue,
    this.badgeSize,
    this.height,
    this.width,
    this.backgroundImage,
    this.size,
    this.semanticLabel,
    this.content,
  });

  Alignment _avatarAlignmentMapper(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    if (isRTL) {
      switch (badgeAlignment) {
        case AvatarBadgeAlignment.topLeft:
          return Alignment.topRight;
        case AvatarBadgeAlignment.topRight:
          return Alignment.topLeft;
        case AvatarBadgeAlignment.bottomLeft:
          return Alignment.bottomRight;
        case AvatarBadgeAlignment.bottomRight:
          return Alignment.bottomLeft;
        default:
          return Alignment.bottomRight;
      }
    }

    switch (badgeAlignment) {
      case AvatarBadgeAlignment.topLeft:
        return Alignment.topLeft;
      case AvatarBadgeAlignment.topRight:
        return Alignment.topRight;
      case AvatarBadgeAlignment.bottomLeft:
        return Alignment.bottomLeft;
      case AvatarBadgeAlignment.bottomRight:
        return Alignment.bottomRight;
      default:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveConfiguration = context.theme.avatarTheme().sizes.select(size);
    final effectiveBorderType = borderType ?? effectiveConfiguration.borderType;
    final effectiveBorderRadius = borderRadius ?? effectiveConfiguration.borderRadius;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.avatarTheme().style.backgroundColor;
    final effectiveBadgeColor = badgeColor ?? context.theme.avatarTheme().style.badgeColor;
    final effectiveTextColor = textColor ?? context.theme.avatarTheme().style.textColor;
    final effectiveIconColor = iconColor ?? context.theme.avatarTheme().style.iconColor;
    final effectiveAvatarHeight = height ?? effectiveConfiguration.avatarSizeValue;
    final effectiveAvatarWidth = width ?? effectiveConfiguration.avatarSizeValue;
    final effectiveBadgeMarginValue = badgeMarginValue ?? effectiveConfiguration.badgeMarginValue;
    final effectiveBadgeSize = badgeSize ?? effectiveConfiguration.badgeSizeValue;

    return Semantics(
      label: semanticLabel,
      button: false,
      focusable: false,
      image: backgroundImage != null,
      child: SizedBox(
        width: effectiveAvatarWidth,
        height: effectiveAvatarHeight,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipPath(
                clipper: kIsWeb && MediaQueryData.fromView(View.of(context)).size.width < 500
                    ? null
                    : AvatarClipper(
                        showBadge: showBadge,
                        width: effectiveAvatarWidth,
                        height: effectiveAvatarHeight,
                        borderRadius: effectiveBorderRadius.resolve(Directionality.of(context)),
                        badgeSize: effectiveBadgeSize,
                        badgeMarginValue: effectiveBadgeMarginValue,
                        badgeAlignment: badgeAlignment,
                        textDirection: Directionality.of(context),
                      ),
                child: DefaultTextStyle(
                  style: effectiveConfiguration.textStyle.copyWith(color: effectiveTextColor),
                  child: IconTheme(
                    data: IconThemeData(
                      color: effectiveIconColor,
                    ),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: effectiveBackgroundColor,
                        image: backgroundImage != null
                            ? DecorationImage(
                                image: backgroundImage!,
                                fit: BoxFit.cover,
                              )
                            : null,
                        shape: switch (effectiveBorderType) {
                          BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius.resolve(Directionality.of(context))),
                          BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                        },
                      ),
                      child: Center(child: content),
                    ),
                  ),
                ),
              ),
            ),
            if (showBadge)
              Align(
                alignment: _avatarAlignmentMapper(context),
                child: Container(
                  height: effectiveBadgeSize,
                  width: effectiveBadgeSize,
                  decoration: BoxDecoration(
                    color: effectiveBadgeColor,
                    borderRadius: BorderRadius.circular(effectiveBadgeSize / 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
