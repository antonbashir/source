import 'package:design/borders/squircle/border.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

class Drawer extends StatelessWidget {
  final Widget content;
  final Widget child;
  final bool show;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? barrierColor;
  final Decoration? decoration;
  final double? width;
  final List<BoxShadow>? drawerShadows;
  final String? semanticLabel;

  const Drawer({
    super.key,
    this.show = true,
    required this.content,
    required this.child,
    this.borderRadius,
    this.backgroundColor,
    this.barrierColor,
    this.decoration,
    this.width,
    this.drawerShadows,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? context.theme.drawerTheme().configuration.borderRadius;
    final effectiveBackgroundColor = backgroundColor ?? context.theme.drawerTheme().style.backgroundColor;
    final effectiveTextColor = context.theme.drawerTheme().style.textColor;
    final effectiveIconColor = context.theme.drawerTheme().style.iconColor;
    final effectiveWidthFromTheme = context.theme.drawerTheme().configuration.width;
    final effectiveWidth = width ?? (MediaQuery.of(context).size.width < effectiveWidthFromTheme ? MediaQuery.of(context).size.width : effectiveWidthFromTheme);
    final effectiveDrawerShadows = drawerShadows ?? context.theme.drawerTheme().style.shadows;
    final effectiveTextStyle = context.theme.drawerTheme().configuration.textStyle;

    return !show
        ? content
        : Semantics(
            explicitChildNodes: true,
            namesRoute: true,
            scopesRoute: true,
            label: semanticLabel,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconTheme(
                  data: IconThemeData(color: effectiveIconColor),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Container(
                      width: effectiveWidth,
                      decoration: decoration ??
                          ShapeDecoration(
                            color: effectiveBackgroundColor,
                            shadows: effectiveDrawerShadows,
                            shape: SquircleBorder(
                              borderRadius: effectiveBorderRadius.squircle(context),
                            ),
                          ),
                      child: child,
                    ),
                  ),
                ),
                content,
              ],
            ),
          );
  }
}
