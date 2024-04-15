import 'package:design/borders/squircle/border.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:design/constants/breakpoints.dart';

class Tag extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final BreakpointSize? size;
  final Decoration? decoration;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  const Tag({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.height,
    this.width,
    this.gap,
    this.padding,
    this.size,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTagConfiguration = context.theme.tagTheme().configuration.select(size);
    final effectiveBorderRadius = borderRadius ?? effectiveTagConfiguration.borderRadius;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.tagTheme().style.backgroundColor;
    final effectiveTextColor = context.theme.tagTheme().style.textColor;
    final effectiveIconColor = context.theme.tagTheme().style.iconColor;
    final effectiveHeight = height ?? effectiveTagConfiguration.height;
    final effectiveGap = gap ?? effectiveTagConfiguration.gap;
    final effectivePadding = padding ?? effectiveTagConfiguration.padding;
    final resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));
    final correctedPadding = padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            leading == null && label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            trailing == null && label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    return Semantics(
      label: semanticLabel,
      button: false,
      focusable: false,
      child: GestureDetector(
        excludeFromSemantics: true,
        onTap: onTap,
        onLongPress: onLongPress,
        child: MouseRegion(
          cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: AbsorbPointer(
            child: Container(
              height: effectiveHeight,
              padding: correctedPadding,
              constraints: BoxConstraints(minWidth: effectiveHeight),
              decoration: decoration ??
                  ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shape: SquircleBorder(
                      borderRadius: effectiveBorderRadius.squircle(context),
                    ),
                  ),
              child: IconTheme(
                data: IconThemeData(
                  color: effectiveIconColor,
                  size: effectiveTagConfiguration.iconSizeValue,
                ),
                child: DefaultTextStyle(
                  style: effectiveTagConfiguration.textStyle.copyWith(color: effectiveTextColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                          child: leading,
                        ),
                      if (label != null) label!,
                      if (trailing != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                          child: trailing,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
