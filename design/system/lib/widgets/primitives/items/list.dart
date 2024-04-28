import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/borders.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:design/widgets/primitives/divider/divider.dart';
import 'package:flutter/widgets.dart';

class ListItem extends StatefulWidget {
  final bool absorbGestures;
  final bool autofocus;
  final Widget label;
  final CrossAxisAlignment? outerCrossAxisAlignment;
  final CrossAxisAlignment? innerCrossAxisAlignment;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? hoverEffectColor;
  final Decoration? decoration;
  final double? height;
  final double? minTouchTargetSize;
  final double? width;
  final double? horizontalGap;
  final double? verticalGap;
  final Duration? hoverEffectDuration;
  final Curve? hoverEffectCurve;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? content;
  final Widget? trailing;

  const ListItem({
    super.key,
    required this.label,
    this.absorbGestures = true,
    this.autofocus = false,
    this.outerCrossAxisAlignment,
    this.innerCrossAxisAlignment,
    this.borderType,
    this.borderRadius,
    this.backgroundColor,
    this.hoverEffectColor,
    this.decoration,
    this.height,
    this.minTouchTargetSize,
    this.width,
    this.horizontalGap,
    this.verticalGap,
    this.hoverEffectDuration,
    this.hoverEffectCurve,
    this.padding,
    this.focusNode,
    this.semanticLabel,
    this.onTap,
    this.leading,
    this.content,
    this.trailing,
  }) : assert(innerCrossAxisAlignment != CrossAxisAlignment.baseline, labelCrossAxisAlignmentAssertion);

  static Iterable<Widget> divided({
    required BuildContext context,
    required Iterable<Widget> items,
    Color? color,
    double? width,
  }) {
    items = items.toList();
    if (items.isEmpty || items.length == 1) return items;
    final Color effectiveColor = color ?? context.theme.listItemTheme().style.dividerColor;

    Widget wrapListItem(Widget listItems) => DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border(
              bottom: HorizontalDivider.createBorderSide(
                context,
                color: effectiveColor,
                width: width,
              ),
            ),
          ),
          child: listItems,
        );

    return <Widget>[
      ...items.take(items.length - 1).map(wrapListItem),
      items.last,
    ];
  }

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with TickerProviderStateMixin {
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController? _animationController;
  Animation<Color?>? _backgroundColor;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? FocusNode();

  void _handleActiveStatus(bool isActive) {
    isActive ? _animationController!.forward() : _animationController!.reverse();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderType = widget.borderType ?? context.theme.listItemTheme().configuration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? context.theme.listItemTheme().configuration.borderRadius;
    final effectiveMinimumHeaderHeight = widget.height ?? context.theme.listItemTheme().configuration.minimumHeight;
    final effectiveVerticalGap = widget.verticalGap ?? context.theme.listItemTheme().configuration.verticalGap;
    final effectiveHeaderPadding = widget.padding ?? context.theme.listItemTheme().configuration.padding;
    final resolvedDirectionalHeaderPadding = effectiveHeaderPadding.resolve(Directionality.of(context));
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.listItemTheme().style.backgroundColor;
    final effectiveIconColor = context.theme.listItemTheme().style.iconColor;
    final effectiveLabelTextColor = context.theme.listItemTheme().style.labelTextColor;
    final effectiveContentTextColor = context.theme.listItemTheme().style.contentTextColor;
    final effectiveLabelTextStyle = context.theme.listItemTheme().configuration.labelTextStyle;
    final effectiveContentTextStyle = context.theme.listItemTheme().configuration.contentTextStyle;
    final effectiveHoverEffectColor = widget.hoverEffectColor ?? context.theme.effectsTheme().hover.color;
    final effectiveMinTargetSize = widget.minTouchTargetSize ?? context.theme.listItemTheme().configuration.minTouchTargetSize;
    final resolvedHoverColor = Color.alphaBlend(effectiveHoverEffectColor, widget.backgroundColor ?? Colors.transparent);
    final effectiveHoverEffectDuration = widget.hoverEffectDuration ?? context.theme.effectsTheme().hover.duration;
    final effectiveHoverEffectCurve = widget.hoverEffectCurve ?? context.theme.effectsTheme().hover.curve;

    _animationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);
    _backgroundColor ??= _animationController!.drive(_backgroundColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = resolvedHoverColor;

    return Semantics(
      label: widget.semanticLabel,
      enabled: widget.onTap != null,
      child: BaseControl(
        showDownscaleEffect: true,
        minTouchTargetSize: effectiveMinTargetSize,
        onTap: widget.onTap,
        propagateGesturesToChild: !widget.absorbGestures,
        autofocus: widget.autofocus,
        focusNode: _effectiveFocusNode,
        borderRadius: effectiveBorderRadius.squircle(context),
        builder: (context, isEnabled, isHovered, isFocused, isPressed) {
          final isActive = isHovered || isFocused;
          _handleActiveStatus(isActive);
          return AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) => Container(
              height: widget.height,
              width: widget.width,
              constraints: BoxConstraints(minHeight: effectiveMinimumHeaderHeight),
              padding: resolvedDirectionalHeaderPadding,
              decoration: widget.decoration ??
                  ShapeDecoration(
                    color: _backgroundColor!.value,
                    shape: switch (effectiveBorderType) {
                      BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                      BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                    },
                  ),
              child: child,
            ),
            child: IconTheme(
              data: IconThemeData(color: effectiveIconColor),
              child: DefaultTextStyle(
                style: effectiveLabelTextStyle.copyWith(color: effectiveLabelTextColor),
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
        },
      ),
    );
  }
}
