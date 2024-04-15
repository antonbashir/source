import 'package:design/effects/focus.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/state.dart';
import 'package:design/painters/radio/radio.dart';
import 'package:design/widgets/mixins/toggleable.dart';
import 'package:design/widgets/paddings/touch.dart';
import 'package:flutter/widgets.dart';
import 'package:design/constants/breakpoints.dart';

class Radio extends StatefulWidget {
  final bool autofocus;
  final bool toggleable;
  final bool selected;
  final BreakpointSize? size;
  final double? sizeValue;
  final double? innerRadius;
  final double? outerRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? tapAreaSizeValue;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final ValueChanged<bool>? onChanged;

  const Radio({
    super.key,
    required this.selected,
    required this.onChanged,
    this.autofocus = false,
    this.toggleable = false,
    this.size,
    this.sizeValue,
    this.innerRadius,
    this.outerRadius,
    this.activeColor,
    this.inactiveColor,
    this.tapAreaSizeValue,
    this.focusNode,
    this.semanticLabel,
  });

  bool get _selected => selected;

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState<T> extends State<Radio> with TickerProviderStateMixin, ToggleableStateMixin {
  late final _painter = RadioPainter(
    innerRadius: widget.innerRadius ?? context.theme.radioTheme().configuration.select(widget.size).innerRadius,
    outerRadius: widget.innerRadius ?? context.theme.radioTheme().configuration.select(widget.size).outerRadius,
  );

  void _handleChanged(bool? selected) => widget.onChanged!(selected ?? false);

  @override
  void didUpdateWidget(Radio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._selected != oldWidget._selected) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get selected => widget._selected;

  @override
  Widget build(BuildContext context) {
    final effectiveConfiguration = context.theme.radioTheme().configuration.select(widget.size);
    final effectiveSize = widget.sizeValue ?? effectiveConfiguration.size;
    final effectiveBorderRadius = effectiveConfiguration.borderRadius;
    final effectiveActiveColor = widget.activeColor ?? context.theme.radioTheme().style.activeColor;
    final effectiveInactiveColor = widget.inactiveColor ?? context.theme.radioTheme().style.inactiveColor;
    final effectiveFocusEffectColor = context.theme.effectsTheme().focus.color;
    final effectiveFocusEffectExtent = context.theme.effectsTheme().focus.extent;
    final effectiveFocusEffectDuration = context.theme.effectsTheme().focus.duration;
    final effectiveFocusEffectCurve = context.theme.effectsTheme().focus.curve;
    final effectiveDisabledOpacityValue = context.tokens.opacities.disabled;
    final effectiveMouseCursor = VisualStateProperty.resolveWith<MouseCursor>(VisualStateMouseCursor.clickable.resolve);
    return Semantics(
      label: widget.semanticLabel,
      inMutuallyExclusiveGroup: true,
      checked: widget._selected,
      child: TouchTargetPadding(
        minSize: Size(
          widget.tapAreaSizeValue ?? effectiveConfiguration.tapAreaSizeValue,
          widget.tapAreaSizeValue ?? effectiveConfiguration.tapAreaSizeValue,
        ),
        child: FocusEffect(
          show: states.contains(VisualState.focused),
          effectExtent: effectiveFocusEffectExtent,
          childBorderRadius: effectiveBorderRadius,
          effectColor: effectiveFocusEffectColor,
          effectCurve: effectiveFocusEffectCurve,
          effectDuration: effectiveFocusEffectDuration,
          child: RepaintBoundary(
            child: AnimatedOpacity(
              opacity: states.contains(VisualState.disabled) ? effectiveDisabledOpacityValue : 1,
              duration: effectiveFocusEffectDuration,
              child: buildToggleable(
                focusNode: widget.focusNode,
                autofocus: widget.autofocus,
                mouseCursor: effectiveMouseCursor,
                size: Size(effectiveSize, effectiveSize),
                painter: _painter
                  ..position = position
                  ..activeColor = effectiveActiveColor
                  ..inactiveColor = effectiveInactiveColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
