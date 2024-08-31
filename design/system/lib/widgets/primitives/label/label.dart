import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/borders.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

class Label extends StatefulWidget {
  final Widget label;
  final CrossAxisAlignment? outerCrossAxisAlignment;
  final CrossAxisAlignment? innerCrossAxisAlignment;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final double? horizontalGap;
  final double? verticalGap;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final Widget? content;
  final Widget? trailing;

  const Label({
    super.key,
    required this.label,
    this.outerCrossAxisAlignment,
    this.innerCrossAxisAlignment,
    this.borderType,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.height,
    this.width,
    this.horizontalGap,
    this.verticalGap,
    this.padding,
    this.leading,
    this.content,
    this.trailing,
  }) : assert(innerCrossAxisAlignment != CrossAxisAlignment.baseline, labelCrossAxisAlignmentAssertion);

  @override
  State<Label> createState() => _ListItemState();
}

class _ListItemState extends State<Label> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final effectiveVerticalGap = widget.verticalGap ?? context.theme.labelTheme().configuration.verticalGap;
    final effectiveHeaderPadding = widget.padding ?? context.theme.labelTheme().configuration.padding;
    final resolvedDirectionalHeaderPadding = effectiveHeaderPadding.resolve(Directionality.of(context));
    final effectiveIconColor = context.theme.labelTheme().style.iconColor;
    final effectiveLabelTextColor = context.theme.labelTheme().style.labelTextColor;
    final effectiveContentTextColor = context.theme.labelTheme().style.contentTextColor;
    final effectiveLabelTextStyle = context.theme.labelTheme().configuration.labelTextStyle;
    final effectiveContentTextStyle = context.theme.labelTheme().configuration.contentTextStyle;
    final effectiveMinimumHeaderHeight = widget.height ?? context.theme.labelTheme().configuration.minimumHeight;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.labelTheme().style.backgroundColor;
    final effectiveBorderType = widget.borderType ?? context.theme.labelTheme().configuration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? context.theme.labelTheme().configuration.borderRadius;
    return IconTheme(
      data: IconThemeData(color: effectiveIconColor),
      child: DefaultTextStyle(
        style: effectiveLabelTextStyle.copyWith(color: effectiveLabelTextColor),
        child: Container(
          height: widget.height,
          width: widget.width,
          constraints: BoxConstraints(minHeight: effectiveMinimumHeaderHeight),
          padding: resolvedDirectionalHeaderPadding,
          decoration: widget.decoration ??
              ShapeDecoration(
                color: effectiveBackgroundColor,
                shape: switch (effectiveBorderType) {
                  BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                  BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context))
                },
              ),
          child: Row(
            crossAxisAlignment: widget.outerCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              if (widget.leading != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: widget.horizontalGap ?? resolvedDirectionalHeaderPadding.left,
                  ),
                  child: widget.leading,
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.innerCrossAxisAlignment ?? CrossAxisAlignment.start,
                  children: [
                    widget.label,
                    if (widget.content != null)
                      DefaultTextStyle(
                        style: effectiveContentTextStyle.copyWith(color: effectiveContentTextColor),
                        child: Padding(
                          padding: EdgeInsets.only(top: effectiveVerticalGap),
                          child: widget.content,
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.trailing != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: widget.horizontalGap ?? resolvedDirectionalHeaderPadding.right,
                  ),
                  child: widget.trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
