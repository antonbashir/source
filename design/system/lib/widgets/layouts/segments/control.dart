import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/borders.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/constants/tabs.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/model/segment.dart';
import 'package:design/theme/primitives/segments/configuration.dart';
import 'package:design/widgets/layouts/tabs/controller/controller.dart';
import 'package:design/widgets/layouts/tabs/views/segmented.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/widgets.dart';

typedef CustomSegmentBuilder = Widget Function(BuildContext context, bool isSelected);

class SegmentedControl extends StatefulWidget {
  final int initialIndex;
  final bool disabled;
  final bool expanded;
  final TabBarDirection direction;
  final Duration? animationDuration;
  final BorderType? borderType;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final double? gap;
  final double? height;
  final double? width;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? padding;
  final BreakpointSize? segmentedControlSize;
  final Decoration? decoration;
  final TabController? tabController;
  final ValueChanged<int>? onSegmentChanged;
  final List<Segment>? segments;
  final List<CustomSegmentBuilder>? customSegments;
  final double? minTouchTargetSize;

  const SegmentedControl({
    super.key,
    required this.segments,
    this.disabled = false,
    this.expanded = false,
    this.initialIndex = 0,
    this.direction = TabBarDirection.row,
    this.borderType,
    this.borderRadius,
    this.animationDuration,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.segmentedControlSize,
    this.decoration,
    this.tabController,
    this.minTouchTargetSize,
    this.onSegmentChanged,
  })  : assert(height == null || height > 0),
        assert(segments != null && segments.length > 0),
        customSegments = null;

  const SegmentedControl.custom({
    super.key,
    required this.customSegments,
    this.disabled = false,
    this.expanded = false,
    this.initialIndex = 0,
    this.direction = TabBarDirection.row,
    this.borderType,
    this.borderRadius,
    this.animationDuration,
    this.backgroundColor,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.segmentedControlSize,
    this.decoration,
    this.tabController,
    this.minTouchTargetSize,
    this.onSegmentChanged,
  })  : assert(height == null || height > 0),
        assert(customSegments != null && customSegments.length > 0),
        segments = null;

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  late final _hasDefaultSegments = widget.segments != null;
  late int _selectedIndex = widget.tabController?.index ?? widget.initialIndex;

  void _updateSegmentsSelectedStatus() {
    if (_hasDefaultSegments) {
      widget.segments!.asMap().forEach((index, segment) => segment.isSelected?.call(index == _selectedIndex));
      return;
    }
    widget.customSegments!.asMap().forEach((index, customSegment) => customSegment(context, index == _selectedIndex));
  }

  void _handleSegmentChange() {
    final animationValue = widget.tabController?.animation?.value.round() ?? 0;
    if (animationValue != _selectedIndex) {
      setState(() {
        _selectedIndex = animationValue;
        widget.onSegmentChanged?.call(animationValue);
        _updateSegmentsSelectedStatus();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSegmentsSelectedStatus();
    widget.tabController?.animation?.addListener(_handleSegmentChange);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSegmentControlConfiguration = context.theme.segmentedControlTheme().configuration.select(widget.segmentedControlSize);
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.segmentedControlTheme().style.backgroundColor;
    final effectiveDisabledOpacityValue = context.tokens.opacities.disabled;
    final effectiveHeight = widget.height ?? effectiveSegmentControlConfiguration.height;
    final effectiveGap = widget.gap ?? effectiveSegmentControlConfiguration.gap;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.segmentedControlTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.segmentedControlTheme().style.transitionCurve;
    final effectivePadding = widget.padding ?? effectiveSegmentControlConfiguration.padding;
    final effectiveBorderType = widget.borderType ?? effectiveSegmentControlConfiguration.borderType;
    final effectiveBorderRadius = widget.borderRadius ?? effectiveSegmentControlConfiguration.borderRadius;
    return AnimatedOpacity(
      opacity: widget.disabled ? effectiveDisabledOpacityValue : 1,
      duration: effectiveTransitionDuration,
      child: Container(
        height: effectiveHeight,
        width: widget.width,
        padding: effectivePadding,
        constraints: BoxConstraints(minWidth: effectiveHeight),
        decoration: widget.decoration ??
            ShapeDecoration(
              color: effectiveBackgroundColor,
              shape: switch (effectiveBorderType) {
                BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
              },
            ),
        child: BaseSegmentedTabBar(
          gap: effectiveGap,
          animationDuration: widget.animationDuration ?? context.theme.tabBarTheme().style.animationDuration,
          isExpanded: widget.expanded,
          initialIndex: widget.initialIndex,
          tabController: widget.tabController,
          direction: widget.direction,
          children: _hasDefaultSegments
              ? List.generate(
                  widget.segments!.length,
                  (index) => _SegmentBuilder(
                    isDisabled: widget.disabled,
                    transitionDuration: effectiveTransitionDuration,
                    transitionCurve: effectiveTransitionCurve,
                    isSelected: index == _selectedIndex,
                    backgroundColor: effectiveBackgroundColor,
                    controlConfiguration: effectiveSegmentControlConfiguration,
                    minTouchTargetSize: widget.minTouchTargetSize ?? effectiveSegmentControlConfiguration.minTouchTargetSize,
                    segment: widget.segments![index],
                  ),
                )
              : List.generate(
                  widget.customSegments!.length,
                  (index) => widget.customSegments![index](context, index == _selectedIndex),
                ),
          valueChanged: (newIndex) {
            if (_selectedIndex == newIndex) return;
            if (widget.disabled) return;
            setState(() {
              _selectedIndex = newIndex;
              if (widget.tabController == null) {
                widget.onSegmentChanged?.call(newIndex);
                _updateSegmentsSelectedStatus();
              }
            });
          },
        ),
      ),
    );
  }
}

class _SegmentBuilder extends StatefulWidget {
  final bool isDisabled;
  final bool isSelected;
  final Color backgroundColor;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final Segment segment;
  final SegmentedControlConfiguration controlConfiguration;
  final double minTouchTargetSize;

  const _SegmentBuilder({
    required this.isDisabled,
    required this.isSelected,
    required this.backgroundColor,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.segment,
    required this.controlConfiguration,
    required this.minTouchTargetSize,
  });

  @override
  State<_SegmentBuilder> createState() => _SegmentBuilderState();
}

class _SegmentBuilderState extends State<_SegmentBuilder> with SingleTickerProviderStateMixin {
  final ColorTween _segmentColorTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();

  Animation<Color?>? _segmentColor;
  Animation<Color?>? _textColor;
  AnimationController? _animationController;

  void _handleActiveEffect(bool isActive) {
    isActive ? _animationController?.forward() : _animationController?.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.transitionDuration, vsync: this);
    if (widget.isSelected) _animationController?.value = 1;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderType = widget.segment.borderType ?? widget.controlConfiguration.segmentBorderType;
    final effectiveBorderRadius = widget.segment.borderRadius ?? widget.controlConfiguration.segmentBorderRadius;
    final effectiveSelectedColor = widget.segment.selectedColor ?? context.theme.segmentedControlTheme().style.selectedSegmentColor;
    final effectiveTextColor = widget.segment.textColor ?? context.theme.segmentedControlTheme().style.segmentTextColor;
    final effectiveSelectedTextColor = widget.segment.selectedTextColor ?? context.theme.segmentedControlTheme().style.selectedSegmentTextColor;
    final effectiveTextStyle = widget.segment.textStyle ?? widget.controlConfiguration.segmentTextStyle;
    final effectiveGap = widget.segment.gap ?? widget.controlConfiguration.segmentGap;
    final effectivePadding = widget.segment.padding ?? widget.controlConfiguration.segmentPadding;
    final effectiveFocusEffectColor = widget.segment.focusEffectColor ?? context.theme.effectsTheme().focus.color;
    final effectiveDecoration = widget.segment.decoration;

    final resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));
    final correctedPadding = widget.segment.padding == null
        ? EdgeInsetsDirectional.fromSTEB(
            widget.segment.leading == null && widget.segment.label != null ? resolvedDirectionalPadding.left : 0,
            resolvedDirectionalPadding.top,
            widget.segment.trailing == null && widget.segment.label != null ? resolvedDirectionalPadding.right : 0,
            resolvedDirectionalPadding.bottom,
          )
        : resolvedDirectionalPadding;

    _segmentColor ??= _animationController!.drive(_segmentColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _textColor ??= _animationController!.drive(_textColorTween.chain(CurveTween(curve: widget.transitionCurve)));
    _segmentColorTween.end = effectiveSelectedColor;

    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveSelectedTextColor;

    return BaseControl(
        onLongPress: widget.isDisabled ? null : () => {},
        autofocus: widget.segment.autoFocus,
        focusNode: widget.segment.focusNode,
        isFocusable: widget.segment.isFocusable,
        showFocusEffect: widget.segment.showFocusEffect,
        focusEffectColor: effectiveFocusEffectColor,
        semanticLabel: widget.segment.semanticLabel,
        borderRadius: switch (effectiveBorderType) {
          BorderType.squircle => effectiveBorderRadius.squircle(context),
          BorderType.rounded => effectiveBorderRadius,
        },
        cursor: widget.isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
        minTouchTargetSize: widget.minTouchTargetSize,
        builder: (context, isEnabled, isHovered, isFocused, isPressed) {
          _handleActiveEffect(isEnabled && (widget.isSelected || isHovered || isPressed));
          return AnimatedBuilder(
            animation: _animationController!,
            builder: (BuildContext context, Widget? child) => DecoratedBox(
              decoration: effectiveDecoration ??
                  ShapeDecoration(
                    color: _segmentColor!.value,
                    shape: switch (effectiveBorderType) {
                      BorderType.squircle => SquircleBorder(borderRadius: effectiveBorderRadius.squircle(context)),
                      BorderType.rounded => RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
                    },
                  ),
              child: IconTheme(
                data: IconThemeData(
                  size: widget.controlConfiguration.iconSizeValue,
                  color: _textColor!.value,
                ),
                child: DefaultTextStyle(
                  style: effectiveTextStyle.copyWith(color: _textColor!.value),
                  child: child!,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: correctedPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.segment.leading != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                        child: widget.segment.leading,
                      ),
                    if (widget.segment.label != null) widget.segment.label!,
                    if (widget.segment.trailing != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                        child: widget.segment.trailing,
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
