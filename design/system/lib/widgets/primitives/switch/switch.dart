import 'package:design/borders/squircle/border.dart';
import 'package:design/borders/squircle/border_radius.dart';
import 'package:design/effects/focus.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:design/constants/breakpoints.dart';

class Switch extends StatefulWidget {
  final bool autofocus;
  final bool hasHapticFeedback;
  final bool value;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final double? height;
  final double? width;
  final double? thumbSizeValue;
  final Duration? duration;
  final Curve? curve;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final BreakpointSize? size;
  final String? semanticLabel;
  final ValueChanged<bool>? onChanged;
  final Widget? activeTrackWidget;
  final Widget? inactiveTrackWidget;
  final Widget? activeThumbWidget;
  final Widget? inactiveThumbWidget;

  const Switch({
    super.key,
    required this.value,
    this.autofocus = false,
    this.hasHapticFeedback = true,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.height,
    this.width,
    this.thumbSizeValue,
    this.duration,
    this.curve,
    this.padding,
    this.focusNode,
    this.size,
    this.semanticLabel,
    this.onChanged,
    this.activeTrackWidget,
    this.inactiveTrackWidget,
    this.activeThumbWidget,
    this.inactiveThumbWidget,
  });

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with SingleTickerProviderStateMixin {
  late final Map<Type, Action<Intent>> _actions = {
    ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap()),
  };

  late Animation<Alignment>? _alignmentAnimation;
  late Animation<Decoration>? _trackDecorationAnimation;

  AnimationController? _animationController;
  Animation<double>? _thumbFadeAnimation;
  Animation<double>? _activeTrackWidgetFadeAnimation;
  Animation<double>? _inactiveTrackWidgetFadeAnimation;
  CurvedAnimation? _curvedAnimation;
  CurvedAnimation? _curvedAnimationWithOvershoot;
  FocusNode? _focusNode;

  bool _isFocused = false;
  bool _needsPositionAnimation = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  bool get _isInteractive => widget.onChanged != null;

  void _resumePositionAnimation({bool isLinear = true}) {
    _needsPositionAnimation = false;

    _curvedAnimationWithOvershoot!
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;

    widget.value ? _animationController!.forward() : _animationController!.reverse();
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused) {
      setState(() => _isFocused = focus);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
  }

  void _handleTapDown(TapDownDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
    }
  }

  void _handleTap() {
    if (_isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
      _emitVibration();
    }
  }

  void _handleDragUpdate({
    required DragUpdateDetails details,
    required double switchWidth,
    required double thumbSizeValue,
    required EdgeInsets padding,
  }) {
    if (_isInteractive) {
      _curvedAnimationWithOvershoot!
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _animationController!.value += -details.primaryDelta! / (switchWidth - (thumbSizeValue + padding.right + padding.left));
        case TextDirection.ltr:
          _animationController!.value += details.primaryDelta! / (switchWidth - (thumbSizeValue + padding.right + padding.left));
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() => _needsPositionAnimation = true);
    if (_curvedAnimationWithOvershoot!.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
  }

  void _emitVibration() {
    if (widget.hasHapticFeedback) HapticFeedback.lightImpact();
  }

  @override
  void didUpdateWidget(Switch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: _needsPositionAnimation);
    }

    if (_curvedAnimationWithOvershoot!.value == 0.0 || _curvedAnimationWithOvershoot!.value == 1.0) {
      _curvedAnimationWithOvershoot!
        ..curve = Curves.easeOutBack
        ..reverseCurve = Curves.easeOutBack.flipped;
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_needsPositionAnimation) _resumePositionAnimation();

    final effectiveSwitchConfiguration = context.theme.switchTheme().configuration.select(widget.size);
    final effectiveActiveTrackColor = widget.activeTrackColor ?? context.theme.switchTheme().style.activeTrackColor;
    final effectiveInactiveTrackColor = widget.inactiveTrackColor ?? context.theme.switchTheme().style.inactiveTrackColor;
    final effectiveThumbColor = widget.thumbColor ?? context.theme.switchTheme().style.thumbColor;
    final effectiveHeight = widget.height ?? effectiveSwitchConfiguration.height;
    final effectiveWidth = widget.width ?? effectiveSwitchConfiguration.width;
    final effectiveThumbSizeValue = widget.thumbSizeValue ?? effectiveSwitchConfiguration.thumbSizeValue;
    final effectivePadding = widget.padding ?? effectiveSwitchConfiguration.padding;
    final resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));
    final effectiveBorderRadius = BorderRadius.circular(effectiveThumbSizeValue / 2);
    final effectiveThumbShadow = context.theme.switchTheme().style.thumbShadows;
    final effectiveDuration = widget.duration ?? context.theme.switchTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.curve ?? context.theme.switchTheme().style.transitionCurve;
    final effectiveFocusEffectExtent = context.theme.effectsTheme().focus.extent;
    final effectiveFocusEffectColor = context.theme.effectsTheme().focus.color;
    final effectiveFocusEffectDuration = context.theme.effectsTheme().focus.duration;
    final effectiveFocusEffectCurve = context.theme.effectsTheme().focus.curve;
    final effectiveDisabledOpacityValue = context.tokens.opacities.disabled;

    _animationController ??= AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: effectiveDuration,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    _curvedAnimationWithOvershoot ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    _alignmentAnimation = AlignmentTween(
      begin: Directionality.of(context) == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
      end: Directionality.of(context) == TextDirection.ltr ? Alignment.centerRight : Alignment.centerLeft,
    ).animate(_curvedAnimationWithOvershoot!);

    _trackDecorationAnimation = DecorationTween(
      begin: ShapeDecoration(
        color: effectiveInactiveTrackColor,
        shape: SquircleBorder(
          borderRadius: SquircleBorderRadius(cornerRadius: effectiveHeight / 2),
        ),
      ),
      end: ShapeDecoration(
        color: effectiveActiveTrackColor,
        shape: SquircleBorder(
          borderRadius: SquircleBorderRadius(cornerRadius: effectiveHeight / 2),
        ),
      ),
    ).animate(_curvedAnimation!);

    _thumbFadeAnimation ??= TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 50.0,
      ),
    ]).animate(_curvedAnimation!);

    _activeTrackWidgetFadeAnimation ??= Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.7, 1.0),
      ),
    );

    _inactiveTrackWidgetFadeAnimation ??= Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.0, 0.3),
      ),
    );

    final effectiveActiveTextColor = context.theme.switchTheme().style.activeTextColor;
    final effectiveInactiveTextColor = context.theme.switchTheme().style.inactiveTextColor;
    final effectiveActiveIconColor = context.theme.switchTheme().style.activeIconColor;
    final effectiveInactiveIconColor = context.theme.switchTheme().style.inactiveIconColor;
    final effectiveThumbIconColor = context.theme.switchTheme().style.thumbIconColor;

    return Semantics(
      label: widget.semanticLabel,
      toggled: widget.value,
      child: FocusableActionDetector(
        enabled: _isInteractive,
        actions: _actions,
        autofocus: widget.autofocus,
        focusNode: _effectiveFocusNode,
        onFocusChange: _handleFocusChange,
        onShowFocusHighlight: _handleFocus,
        mouseCursor: _isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          excludeFromSemantics: true,
          onTap: _handleTap,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: (DragUpdateDetails details) => _handleDragUpdate(
            details: details,
            switchWidth: effectiveWidth,
            thumbSizeValue: effectiveThumbSizeValue,
            padding: resolvedDirectionalPadding,
          ),
          onHorizontalDragEnd: _handleDragEnd,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _animationController!,
              builder: (BuildContext context, Widget? child) => AnimatedOpacity(
                opacity: _isInteractive ? 1 : effectiveDisabledOpacityValue,
                duration: effectiveDuration,
                curve: effectiveTransitionCurve,
                child: SizedBox(
                  width: effectiveWidth,
                  height: effectiveHeight,
                  child: DecoratedBoxTransition(
                    decoration: _trackDecorationAnimation!,
                    child: Padding(
                      padding: resolvedDirectionalPadding,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconTheme(
                                data: IconThemeData(
                                  color: effectiveActiveIconColor,
                                  size: effectiveSwitchConfiguration.iconSizeValue,
                                ),
                                child: DefaultTextStyle(
                                  style: effectiveSwitchConfiguration.textStyle.copyWith(
                                    color: effectiveActiveTextColor,
                                  ),
                                  child: Expanded(
                                    child: FadeTransition(
                                      opacity: _activeTrackWidgetFadeAnimation!,
                                      child: widget.activeTrackWidget ?? const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: resolvedDirectionalPadding.left),
                              IconTheme(
                                data: IconThemeData(
                                  color: effectiveInactiveIconColor,
                                  size: effectiveSwitchConfiguration.iconSizeValue,
                                ),
                                child: DefaultTextStyle(
                                  style: effectiveSwitchConfiguration.textStyle.copyWith(
                                    color: effectiveInactiveTextColor,
                                  ),
                                  child: Expanded(
                                    child: FadeTransition(
                                      opacity: _inactiveTrackWidgetFadeAnimation!,
                                      child: widget.inactiveTrackWidget ?? const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: _alignmentAnimation!.value,
                            child: IconTheme(
                              data: IconThemeData(
                                color: effectiveThumbIconColor,
                                size: effectiveSwitchConfiguration.iconSizeValue,
                              ),
                              child: DefaultTextStyle(
                                style: effectiveSwitchConfiguration.textStyle.copyWith(
                                  color: effectiveInactiveTextColor,
                                ),
                                child: FocusEffect(
                                  show: _isFocused,
                                  effectColor: effectiveFocusEffectColor,
                                  childBorderRadius: effectiveBorderRadius,
                                  effectExtent: effectiveFocusEffectExtent,
                                  effectDuration: effectiveFocusEffectDuration,
                                  effectCurve: effectiveFocusEffectCurve,
                                  child: Container(
                                    width: effectiveThumbSizeValue,
                                    height: effectiveThumbSizeValue,
                                    alignment: Alignment.center,
                                    decoration: ShapeDecoration(
                                      color: effectiveThumbColor,
                                      shadows: effectiveThumbShadow,
                                      shape: SquircleBorder(
                                        borderRadius: effectiveBorderRadius.squircle(context),
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: _thumbFadeAnimation!,
                                      child: _curvedAnimation!.value > 0.5 ? widget.activeThumbWidget : widget.inactiveThumbWidget,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
