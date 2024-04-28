import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/effects/focus.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/state.dart';
import 'package:design/painters/checkbox/checkbox.dart';
import 'package:design/widgets/mixins/toggleable.dart';
import 'package:design/widgets/paddings/touch.dart';
import 'package:flutter/widgets.dart';
import 'package:design/constants/breakpoints.dart';

class Checkbox extends StatefulWidget {
  final bool autofocus;
  final bool tristate;
  final BreakpointSize? size;
  final double? sizeValue;
  final double? strokeWidth;
  final bool? value;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? borderColor;
  final Color? checkColor;
  final double? tapAreaSizeValue;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final ValueChanged<bool?>? onChanged;

  const Checkbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.autofocus = false,
    this.tristate = false,
    this.size,
    this.strokeWidth,
    this.sizeValue,
    this.activeColor,
    this.borderColor,
    this.checkColor,
    this.inactiveColor,
    this.tapAreaSizeValue,
    this.focusNode,
    this.semanticLabel,
  });

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> with TickerProviderStateMixin, ToggleableStateMixin {
  late final CheckboxPainter _painter = CheckboxPainter(
    size: widget.sizeValue ?? context.theme.checkboxTheme().configuration.select(widget.size).size,
    strokeWidth: widget.strokeWidth ?? context.theme.checkboxTheme().configuration.select(widget.size).strokeWidth,
  );

  bool? _previousValue;

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.tristate;

  @override
  bool? get selected => widget.value;

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is VisualStateBorderSide) return VisualStateProperty.resolveAs<BorderSide?>(side, states);
    if (!states.contains(VisualState.selected)) return side;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveConfiguration = context.theme.checkboxTheme().configuration.select(widget.size);
    final effectiveSize = widget.sizeValue ?? context.theme.checkboxTheme().configuration.select(widget.size).size;
    final effectiveBorderType = effectiveConfiguration.borderType;
    final effectiveBorderRadius = effectiveConfiguration.borderRadius;
    final effectiveActiveColor = widget.activeColor ?? context.theme.checkboxTheme().style.activeColor;
    final effectiveInactiveColor = widget.inactiveColor ?? context.theme.checkboxTheme().style.inactiveColor;
    final effectiveCheckColor = widget.checkColor ?? context.theme.checkboxTheme().style.checkColor;
    final effectiveBorderColor = widget.borderColor ?? context.theme.checkboxTheme().style.borderColor;
    final effectiveFocusEffectColor = context.theme.effectsTheme().focus.color;
    final effectiveFocusEffectDuration = context.theme.effectsTheme().focus.duration;
    final effectiveFocusEffectCurve = context.theme.effectsTheme().focus.curve;
    final effectiveFocusEffectExtent = context.theme.effectsTheme().focus.extent;
    final effectiveDisabledOpacityValue = context.tokens.opacities.disabled;
    final effectiveMouseCursor = VisualStateProperty.resolveWith<MouseCursor>(VisualStateMouseCursor.clickable.resolve);
    return Semantics(
      label: widget.semanticLabel,
      checked: widget.value ?? false,
      mixed: widget.tristate ? widget.value == null : null,
      child: TouchTargetPadding(
        minSize: Size(
          widget.tapAreaSizeValue ?? effectiveConfiguration.tapAreaSizeValue,
          widget.tapAreaSizeValue ?? effectiveConfiguration.tapAreaSizeValue,
        ),
        child: RepaintBoundary(
          child: FocusEffect(
            show: states.contains(VisualState.focused),
            childBorderRadius: effectiveBorderRadius,
            effectColor: effectiveFocusEffectColor,
            effectCurve: effectiveFocusEffectCurve,
            effectDuration: effectiveFocusEffectDuration,
            effectExtent: effectiveFocusEffectExtent,
            child: ScaleTransition(
              scale: positionController.drive(
                TweenSequence([
                  TweenSequenceItem(weight: 50, tween: Tween(begin: 1, end: 1 + context.theme.effectsTheme().scale.upscale)),
                  TweenSequenceItem(weight: 50, tween: Tween(begin: 1 + context.theme.effectsTheme().scale.upscale, end: 1))
                ]),
              ),
              child: AnimatedOpacity(
                opacity: states.contains(VisualState.disabled) ? effectiveDisabledOpacityValue : 1,
                duration: effectiveFocusEffectDuration,
                child: buildToggleable(
                  mouseCursor: effectiveMouseCursor,
                  focusNode: widget.focusNode,
                  autofocus: widget.autofocus,
                  size: Size(effectiveSize, effectiveSize),
                  painter: _painter
                    ..position = position
                    ..activeColor = effectiveActiveColor
                    ..inactiveColor = effectiveInactiveColor
                    ..checkColor = effectiveCheckColor
                    ..value = selected
                    ..previousValue = _previousValue
                    ..shape = switch (effectiveBorderType) {
                      BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                      BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                    }
                    ..side = _resolveSide(BorderSide(color: effectiveBorderColor)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
