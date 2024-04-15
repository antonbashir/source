import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/buttons.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/widgets.dart';

class Button extends StatefulWidget {
  final bool autofocus;
  final bool isFocusable;
  final bool isFullWidth;
  final bool showBorder;
  final bool showFocusEffect;
  final bool showPulseEffect;
  final bool showPulseEffectJiggle;
  final bool showScaleEffect;
  final ButtonVariant variant;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusEffectColor;
  final Color? hoverEffectColor;
  final Color? pulseEffectColor;
  final Color? contentColor;
  final Color? hoverContentColor;
  final Decoration? decoration;
  final double? borderWidth;
  final double? disabledOpacityValue;
  final double? gap;
  final double? height;
  final double? width;
  final double? minTouchTargetSize;
  final double? focusEffectExtent;
  final double? pulseEffectExtent;
  final double? scaleEffectScalar;
  final Duration? focusEffectDuration;
  final Duration? hoverEffectDuration;
  final Duration? pulseEffectDuration;
  final Duration? scaleEffectDuration;
  final Curve? focusEffectCurve;
  final Curve? hoverEffectCurve;
  final Curve? pulseEffectCurve;
  final Curve? scaleEffectCurve;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final BreakpointSize? size;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  const Button({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showPulseEffect = true,
    this.showPulseEffectJiggle = true,
    this.showScaleEffect = false,
    this.variant = ButtonVariant.base,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.pulseEffectColor,
    this.contentColor,
    this.hoverContentColor,
    this.decoration,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.padding,
    this.focusNode,
    this.size,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  const Button.icon({
    super.key,
    this.autofocus = false,
    this.isFocusable = true,
    this.isFullWidth = false,
    this.showBorder = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showScaleEffect = true,
    this.variant = ButtonVariant.icon,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusEffectColor,
    this.hoverEffectColor,
    this.pulseEffectColor,
    this.hoverContentColor,
    this.borderWidth,
    this.disabledOpacityValue,
    this.gap,
    this.height,
    this.width,
    this.minTouchTargetSize,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectScalar,
    this.focusEffectDuration,
    this.hoverEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.hoverEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.padding,
    this.focusNode,
    this.size,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    Color? iconColor,
    Widget? icon,
  })  : contentColor = iconColor,
        leading = icon,
        label = null,
        trailing = null;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  final ColorTween _backgroundColorTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();

  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _textColor;

  AnimationController? _animationController;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;

  void _handleHoverEffect(bool shouldAnimate) {
    shouldAnimate ? _animationController?.forward() : _animationController?.reverse();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveButtonConfiguration = context.theme.buttonTheme().configuration.select(widget.size);
    final effectiveBorderRadius = widget.borderRadius ?? effectiveButtonConfiguration.borderRadius;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.buttonTheme().style.selectColors(widget.variant).background;
    final effectiveBorderColor = widget.borderColor ?? context.theme.buttonTheme().style.selectColors(widget.variant).border;
    final effectiveContentColor = widget.contentColor ?? context.theme.buttonTheme().style.selectColors(widget.variant).content;
    final effectiveHoverContentColor = widget.hoverContentColor ?? context.theme.buttonTheme().style.selectColors(widget.variant).hoverContent;
    final effectiveHoverEffectColor = widget.hoverEffectColor ?? context.theme.buttonTheme().style.selectColors(widget.variant).hover;
    final effectiveBorderWidth = widget.borderWidth ?? effectiveButtonConfiguration.borderWidth;
    final hoverColor = Color.alphaBlend(effectiveHoverEffectColor, effectiveBackgroundColor);
    final effectiveHeight = widget.height ?? effectiveButtonConfiguration.height;
    final effectiveGap = widget.gap ?? effectiveButtonConfiguration.gap;
    final effectivePadding = widget.padding ?? effectiveButtonConfiguration.padding;
    final resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));
    final correctedPadding = widget.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.leading == null && widget.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            widget.trailing == null && widget.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    final effectiveHoverEffectDuration = widget.hoverEffectDuration ?? context.theme.effectsTheme().hover.duration;
    final effectiveHoverEffectCurve = widget.hoverEffectCurve ?? context.theme.effectsTheme().hover.curve;

    _animationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);
    _backgroundColor ??= _animationController!.drive(_backgroundColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));
    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));

    _backgroundColorTween
      ..begin = widget.backgroundColor
      ..end = hoverColor;

    _textColorTween
      ..begin = effectiveContentColor
      ..end = effectiveHoverContentColor;

    return BaseControl(
      autofocus: widget.autofocus,
      isFocusable: widget.isFocusable,
      semanticTypeIsButton: true,
      showFocusEffect: widget.showFocusEffect,
      showPulseEffect: widget.showPulseEffect,
      showPulseEffectJiggle: widget.showPulseEffectJiggle,
      showUpscaleEffect: widget.showScaleEffect,
      showDownscaleEffect: widget.showScaleEffect,
      borderRadius: effectiveBorderRadius,
      backgroundColor: effectiveBackgroundColor,
      focusEffectColor: widget.focusEffectColor,
      pulseEffectColor: widget.pulseEffectColor,
      disabledOpacityValue: widget.disabledOpacityValue,
      minTouchTargetSize: widget.minTouchTargetSize ?? effectiveButtonConfiguration.minTouchTargetSize,
      focusEffectExtent: widget.focusEffectExtent,
      pulseEffectExtent: widget.pulseEffectExtent,
      scaleEffectUpscale: widget.scaleEffectScalar,
      focusEffectDuration: widget.focusEffectDuration,
      pulseEffectDuration: widget.pulseEffectDuration,
      scaleEffectDuration: widget.scaleEffectDuration,
      focusEffectCurve: widget.focusEffectCurve,
      pulseEffectCurve: widget.pulseEffectCurve,
      scaleEffectCurve: widget.scaleEffectCurve,
      focusNode: widget.focusNode,
      semanticLabel: widget.semanticLabel,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        final canAnimate = _isEnabled && (isHovered || isFocused || isPressed);
        _handleHoverEffect(canAnimate);
        return AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) => IconTheme(
            data: IconThemeData(
              color: _textColor!.value,
              size: effectiveButtonConfiguration.iconSizeValue,
            ),
            child: DefaultTextStyle(
              style: effectiveButtonConfiguration.textStyle.copyWith(color: _textColor!.value),
              child: Container(
                width: widget.width,
                height: effectiveHeight,
                constraints: BoxConstraints(minWidth: effectiveHeight),
                decoration: widget.decoration ??
                    ShapeDecoration(
                      color: _backgroundColor!.value,
                      shape: SquircleBorder(
                        borderRadius: effectiveBorderRadius.squircle(context),
                        side: BorderSide(
                          color: effectiveBorderColor,
                          width: widget.showBorder ? effectiveBorderWidth : 0,
                          style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                        ),
                      ),
                    ),
                child: child,
              ),
            ),
          ),
          child: Padding(
            padding: widget.isFullWidth ? EdgeInsets.zero : correctedPadding,
            child: widget.isFullWidth
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.leading != null)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                          alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
                          child: widget.leading,
                        ),
                      if (widget.label != null)
                        Align(
                          child: widget.label,
                        ),
                      if (widget.trailing != null)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: effectiveGap),
                          alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.centerRight : Alignment.centerLeft,
                          child: widget.trailing,
                        ),
                    ],
                  )
                : Row(
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
          ),
        );
      },
    );
  }
}
