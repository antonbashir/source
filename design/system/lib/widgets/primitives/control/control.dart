import 'package:design/effects/focus.dart';
import 'package:design/effects/pulse.dart';
import 'package:design/effects/scale.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/paddings/touch.dart';
import 'package:flutter/widgets.dart';

typedef BaseControlBuilder = Widget Function(
  BuildContext context,
  bool isEnabled,
  bool isHovered,
  bool isFocused,
  bool isPressed,
);

class BaseControl extends StatefulWidget {
  final bool autofocus;
  final bool absorbDragEvents;
  final bool isFocusable;
  final bool semanticTypeIsButton;
  final bool propagateGesturesToChild;
  final bool showFocusEffect;
  final bool showPulseEffect;
  final bool showPulseEffectJiggle;
  final bool showUpscaleEffect;
  final bool showDownscaleEffect;
  final double minTouchTargetSize;
  final MouseCursor cursor;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? focusEffectColor;
  final Color? pulseEffectColor;
  final double? disabledOpacityValue;
  final double? focusEffectExtent;
  final double? pulseEffectExtent;
  final double? scaleEffectUpscale;
  final double? scaleEffectDownscale;
  final Duration? focusEffectDuration;
  final Duration? pulseEffectDuration;
  final Duration? scaleEffectDuration;
  final Curve? focusEffectCurve;
  final Curve? pulseEffectCurve;
  final Curve? scaleEffectCurve;
  final FocusNode? focusNode;
  final BaseControlBuilder? builder;
  final String? semanticLabel;
  final void Function(bool)? onFocus;
  final void Function(bool)? onHover;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  const BaseControl({
    super.key,
    required this.minTouchTargetSize,
    this.autofocus = false,
    this.absorbDragEvents = false,
    this.isFocusable = true,
    this.semanticTypeIsButton = false,
    this.propagateGesturesToChild = false,
    this.showFocusEffect = true,
    this.showPulseEffect = false,
    this.showPulseEffectJiggle = true,
    this.showUpscaleEffect = false,
    this.showDownscaleEffect = false,
    this.borderRadius = BorderRadius.zero,
    this.cursor = SystemMouseCursors.click,
    this.backgroundColor,
    this.focusEffectColor,
    this.pulseEffectColor,
    this.disabledOpacityValue,
    this.focusEffectExtent,
    this.pulseEffectExtent,
    this.scaleEffectUpscale,
    this.scaleEffectDownscale,
    this.focusEffectDuration,
    this.pulseEffectDuration,
    this.scaleEffectDuration,
    this.focusEffectCurve,
    this.pulseEffectCurve,
    this.scaleEffectCurve,
    this.focusNode,
    this.builder,
    this.semanticLabel,
    this.onFocus,
    this.onHover,
    this.onTap,
    this.onLongPress,
    this.child,
  });

  @override
  State<BaseControl> createState() => _BaseControlState();
}

class _BaseControlState extends State<BaseControl> {
  late Map<Type, Action<Intent>> _actions;

  FocusNode? _focusNode;

  bool _isFocused = false;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isLongPressed = false;

  bool get _isEnabled => widget.onTap != null || widget.onLongPress != null;
  bool get _canAnimateFocus => widget.showFocusEffect && _isEnabled && _isFocused;
  bool get _canAnimatePulse => widget.showPulseEffect && _isEnabled;
  bool get _canAnimateDownscale => widget.showDownscaleEffect && _isEnabled && (_isPressed || _isLongPressed);
  bool get _canAnimateUpscale => widget.showUpscaleEffect && _isEnabled && _isHovered;
  MouseCursor get _cursor => _isEnabled ? widget.cursor : SystemMouseCursors.basic;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: !widget.isFocusable));

  void _handleHover(bool hover) {
    if (hover != _isHovered) {
      setState(() => _isHovered = hover);
      widget.onHover?.call(hover);
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused) {
      setState(() => _isFocused = focus);
      widget.onFocus?.call(focus);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
      if (!hasFocus) {
        _isPressed = false;
      }
    });
  }

  void _handleTap() {
    if (_isEnabled) {
      setState(() => _isPressed = true);
      widget.onTap?.call();
      setState(() => _isPressed = false);
    }
  }

  void _handleTapDown(_) {
    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(_) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleLongPress() {
    if (widget.onLongPress == null) return;

    if (_isEnabled) {
      widget.onLongPress?.call();
    }
  }

  void _handleLongPressStart(_) {
    if (!_isLongPressed) {
      setState(() => _isLongPressed = true);
    }

    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
  }

  void _handleLongPressUp() {
    if (widget.onLongPress == null) {
      widget.onTap?.call();
    }

    if (_isLongPressed) {
      setState(() => _isLongPressed = false);
    }

    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleHorizontalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleHorizontalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  void _handleVerticalDragStart(DragStartDetails dragStartDetails) => _handleTapDown(null);

  void _handleVerticalDragEnd(DragEndDetails dragEndDetails) => _handleTapUp(null);

  @override
  void initState() {
    super.initState();
    _actions = <Type, Action<Intent>>{ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())};
    _focusNode = FocusNode(canRequestFocus: _isEnabled, skipTraversal: !widget.isFocusable);
    _effectiveFocusNode.canRequestFocus = _isEnabled;
    if (widget.autofocus) {
      _effectiveFocusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(BaseControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onTap != oldWidget.onTap || widget.onLongPress != oldWidget.onLongPress) {
      if (!_isEnabled) {
        _isHovered = _isPressed = false;
      }
    }
    _effectiveFocusNode.canRequestFocus = _isEnabled;
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDisabledOpacityValue = widget.disabledOpacityValue ?? context.tokens.opacities.disabled;
    final effectiveFocusEffectColor = widget.focusEffectColor ?? context.theme.effectsTheme().focus.color;
    final effectiveFocusEffectExtent = widget.focusEffectExtent ?? context.theme.effectsTheme().focus.extent;
    final effectiveFocusEffectDuration = widget.focusEffectDuration ?? context.theme.effectsTheme().focus.duration;
    final effectiveFocusEffectCurve = widget.focusEffectCurve ?? context.theme.effectsTheme().focus.curve;
    final effectivePulseEffectColor = widget.pulseEffectColor ?? context.theme.effectsTheme().pulse.color;
    final effectivePulseEffectExtent = widget.pulseEffectExtent ?? context.theme.effectsTheme().pulse.extent;
    final effectivePulseEffectDuration = widget.pulseEffectDuration ?? context.theme.effectsTheme().pulse.duration;
    final effectivePulseEffectCurve = widget.pulseEffectCurve ?? context.theme.effectsTheme().pulse.curve;
    final effectiveScaleEffectUpscale = widget.scaleEffectUpscale ?? context.theme.effectsTheme().scale.upscale;
    final effectiveScaleEffectDownscale = widget.scaleEffectDownscale ?? context.theme.effectsTheme().scale.downscale;
    final effectiveScaleEffectDuration = widget.scaleEffectDuration ?? context.theme.effectsTheme().scale.duration;
    final effectiveScaleEffectCurve = widget.scaleEffectCurve ?? context.theme.effectsTheme().scale.curve;
    final child = widget.child ??
        widget.builder!(
          context,
          _isEnabled,
          _isHovered,
          _isFocused,
          _isPressed,
        );
    return MergeSemantics(
      child: Semantics(
        label: widget.semanticLabel,
        button: widget.semanticTypeIsButton,
        enabled: _isEnabled,
        focusable: _isEnabled,
        focused: _isFocused,
        child: AbsorbPointer(
          absorbing: !_isEnabled,
          child: FocusableActionDetector(
            enabled: _isEnabled,
            actions: _actions,
            mouseCursor: _cursor,
            focusNode: _effectiveFocusNode,
            autofocus: _isEnabled && widget.isFocusable && widget.autofocus,
            descendantsAreFocusable: _isEnabled,
            descendantsAreTraversable: _isEnabled,
            onFocusChange: _handleFocusChange,
            onShowFocusHighlight: _handleFocus,
            onShowHoverHighlight: _handleHover,
            child: GestureDetector(
              excludeFromSemantics: true,
              onTap: _handleTap,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onLongPress: _handleLongPress,
              onLongPressStart: _handleLongPressStart,
              onLongPressUp: _handleLongPressUp,
              onTapCancel: _handleTapCancel,
              onHorizontalDragStart: widget.absorbDragEvents ? _handleHorizontalDragStart : null,
              onHorizontalDragEnd: widget.absorbDragEvents ? _handleHorizontalDragEnd : null,
              onVerticalDragStart: widget.absorbDragEvents ? _handleVerticalDragStart : null,
              onVerticalDragEnd: widget.absorbDragEvents ? _handleVerticalDragEnd : null,
              child: TouchTargetPadding(
                minSize: Size(widget.minTouchTargetSize, widget.minTouchTargetSize),
                child: AbsorbPointer(
                  absorbing: !widget.propagateGesturesToChild,
                  child: RepaintBoundary(
                    child: ScaleEffect(
                      scaleUp: _canAnimateUpscale,
                      scaleDown: _canAnimateDownscale,
                      upscaleBound: effectiveScaleEffectUpscale,
                      downscaleBound: effectiveScaleEffectDownscale,
                      duration: effectiveScaleEffectDuration,
                      curve: effectiveScaleEffectCurve,
                      child: PulseEffect(
                        show: _canAnimatePulse,
                        showJiggle: widget.showPulseEffectJiggle,
                        childBorderRadius: widget.borderRadius,
                        effectColor: effectivePulseEffectColor,
                        effectExtent: effectivePulseEffectExtent,
                        effectCurve: effectivePulseEffectCurve,
                        effectDuration: effectivePulseEffectDuration,
                        child: AnimatedOpacity(
                          opacity: _isEnabled ? 1 : effectiveDisabledOpacityValue,
                          duration: context.tokens.transitions.transitionDuration,
                          curve: context.tokens.transitions.transitionCurve,
                          child: FocusEffect(
                            show: _canAnimateFocus,
                            effectColor: effectiveFocusEffectColor,
                            effectExtent: effectiveFocusEffectExtent,
                            effectCurve: effectiveFocusEffectCurve,
                            effectDuration: effectiveFocusEffectDuration,
                            childBorderRadius: widget.borderRadius,
                            child: child,
                          ),
                        ),
                      ),
                    ),
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
