import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/widgets.dart';

class Chip extends StatefulWidget {
  final bool autofocus;
  final bool isFocusable;
  final bool isActive;
  final bool showBorder;
  final bool showFocusEffect;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? activeBorderColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final Color? borderColor;
  final Color? focusEffectColor;
  final Color? textColor;
  final Decoration? decoration;
  final double? borderWidth;
  final double? disabledOpacityValue;
  final double? focusEffectExtent;
  final double? gap;
  final double? height;
  final double? width;
  final double? minTouchTargetSize;
  final Duration? activeEffectDuration;
  final Duration? focusEffectDuration;
  final Curve? activeEffectCurve;
  final Curve? focusEffectCurve;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final BreakpointSize? size;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  const Chip({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isActive = false,
    this.showBorder = true,
    this.showFocusEffect = true,
    this.borderType,
    this.borderRadius,
    this.activeBorderColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.textColor,
    this.decoration,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.activeEffectDuration,
    this.focusEffectDuration,
    this.activeEffectCurve,
    this.focusEffectCurve,
    this.padding,
    this.focusNode,
    this.size,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  });

  const Chip.text({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isActive = false,
    this.showBorder = true,
    this.showFocusEffect = true,
    this.borderType,
    this.borderRadius,
    this.activeBorderColor,
    this.activeBackgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.textColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.focusEffectDuration,
    this.activeEffectDuration,
    this.focusEffectCurve,
    this.activeEffectCurve,
    this.padding,
    this.focusNode,
    this.size,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.label,
    this.leading,
    this.trailing,
  }) : backgroundColor = Colors.transparent;

  @override
  State<Chip> createState() => _ChipState();
}

class _ChipState extends State<Chip> with SingleTickerProviderStateMixin {
  final ColorTween _backgroundColorTween = ColorTween();
  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();

  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _borderColor;
  Animation<Color?>? _textColor;
  AnimationController? _animationController;

  void _handleActiveEffect(bool shouldAnimate) => shouldAnimate ? _animationController?.forward() : _animationController?.reverse();

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveChipConfiguration = context.theme.chipTheme().configuration.select(widget.size);
    final effectiveBorderType = widget.borderType ?? effectiveChipConfiguration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? effectiveChipConfiguration.borderRadius;
    final effectiveBorderWidth = widget.borderWidth ?? effectiveChipConfiguration.borderWidth;
    final effectiveHeight = widget.height ?? effectiveChipConfiguration.height;
    final effectiveGap = widget.gap ?? effectiveChipConfiguration.gap;
    final effectiveActiveColor = widget.activeBorderColor ?? context.theme.chipTheme().style.activeBorderColor;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.chipTheme().style.backgroundColor;
    final effectiveActiveBackgroundColor = widget.activeBackgroundColor ?? context.theme.chipTheme().style.activeBackgroundColor;
    final effectiveTextColor = widget.textColor ?? context.theme.chipTheme().style.contentColor;
    final effectiveActiveEffectDuration = widget.activeEffectDuration ?? context.theme.effectsTheme().hover.duration;
    final effectiveActiveEffectCurve = widget.activeEffectCurve ?? context.theme.effectsTheme().hover.curve;
    final effectivePadding = widget.padding ?? effectiveChipConfiguration.padding;
    final resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));
    final EdgeInsetsGeometry correctedPadding = widget.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.leading == null && widget.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            widget.trailing == null && widget.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _animationController ??= AnimationController(duration: effectiveActiveEffectDuration, vsync: this);
    _backgroundColor ??= _animationController!.drive(_backgroundColorTween.chain(CurveTween(curve: effectiveActiveEffectCurve)));
    _borderColor ??= _animationController!.drive(_borderColorTween.chain(CurveTween(curve: effectiveActiveEffectCurve)));
    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: effectiveActiveEffectCurve)));

    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveActiveBackgroundColor;

    _borderColorTween
      ..begin = context.colors.border
      ..end = widget.borderColor ?? effectiveActiveColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveActiveColor;

    return BaseControl(
      autofocus: widget.autofocus,
      isFocusable: widget.isFocusable,
      showFocusEffect: widget.showFocusEffect,
      borderRadius: effectiveBorderRadius,
      backgroundColor: widget.backgroundColor,
      focusEffectColor: widget.focusEffectColor,
      disabledOpacityValue: widget.disabledOpacityValue,
      minTouchTargetSize: widget.minTouchTargetSize ?? effectiveChipConfiguration.minTouchTargetSize,
      focusEffectExtent: widget.focusEffectExtent,
      focusEffectDuration: widget.focusEffectDuration,
      focusEffectCurve: widget.focusEffectCurve,
      focusNode: widget.focusNode,
      semanticLabel: widget.semanticLabel,
      onTap: widget.onTap ?? () {},
      onLongPress: widget.onLongPress,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final canAnimate = widget.isActive || isHovered || isFocused;
        _handleActiveEffect(canAnimate);
        return AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => IconTheme(
            data: IconThemeData(
              color: _textColor!.value,
              size: effectiveChipConfiguration.iconSizeValue,
            ),
            child: DefaultTextStyle(
              style: effectiveChipConfiguration.textStyle.copyWith(color: _textColor!.value),
              child: Container(
                width: widget.width,
                height: effectiveHeight,
                padding: correctedPadding,
                constraints: BoxConstraints(minWidth: effectiveHeight),
                decoration: widget.decoration ??
                    ShapeDecoration(
                        color: _backgroundColor!.value,
                        shape: switch (effectiveBorderType) {
                          BorderType.rounded => RoundedRectangleBorder(
                              borderRadius: effectiveBorderRadius,
                              side: BorderSide(
                                color: widget.showBorder ? _borderColor!.value! : Colors.transparent,
                                width: widget.showBorder ? effectiveBorderWidth : 0,
                                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                              ),
                            ),
                          BorderType.squircle => SquircleBorder(
                              borderRadius: effectiveBorderRadius.squircle(context),
                              side: BorderSide(
                                color: widget.showBorder ? _borderColor!.value! : Colors.transparent,
                                width: widget.showBorder ? effectiveBorderWidth : 0,
                                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                              ),
                            ),
                        }),
                child: child,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.leading != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: widget.leading,
                ),
              if (widget.label != null) widget.label!,
              if (widget.trailing != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: widget.trailing,
                ),
            ],
          ),
        );
      },
    );
  }
}
