import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/breakpoints.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/composites/accordion/configuration.dart';
import 'package:design/widgets/icons/icons.dart';
import 'package:design/widgets/primitives/control/control.dart';
import 'package:flutter/widgets.dart';

class Accordion<T> extends StatefulWidget {
  final bool autofocus;
  final bool initiallyExpanded;
  final bool disabled;
  final bool maintainState;
  final bool showBorder;
  final bool showDivider;
  final Widget child;
  final double? width;
  final AlignmentGeometry? expandedAlignment;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clipBehavior;
  final Color? iconColor;
  final Color? expandedIconColor;
  final Color? textColor;
  final Color? expandedTextColor;
  final Color? backgroundColor;
  final Color? expandedBackgroundColor;
  final Color? borderColor;
  final Color? dividerColor;
  final Decoration? decoration;
  final double? gap;
  final double? headerHeight;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? headerPadding;
  final FocusNode? focusNode;
  final List<BoxShadow>? shadows;
  final BreakpointSize? size;
  final String? semanticLabel;
  final T? identityValue;
  final T? groupIdentityValue;
  final ValueChanged<T?>? onExpansionChanged;
  final Widget? leading;
  final Widget label;
  final Widget? trailing;
  final double? minTouchTargetSize;

  const Accordion({
    super.key,
    required this.label,
    this.autofocus = false,
    this.initiallyExpanded = false,
    this.disabled = false,
    this.maintainState = false,
    this.showBorder = false,
    this.showDivider = true,
    required this.child,
    this.expandedAlignment,
    this.width,
    this.borderRadius,
    this.clipBehavior,
    this.iconColor,
    this.expandedIconColor,
    this.textColor,
    this.expandedTextColor,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.borderColor,
    this.dividerColor,
    this.decoration,
    this.gap,
    this.headerHeight,
    this.transitionDuration,
    this.transitionCurve,
    this.childrenPadding,
    this.headerPadding,
    this.focusNode,
    this.shadows,
    this.size,
    this.semanticLabel,
    this.identityValue,
    this.groupIdentityValue,
    this.onExpansionChanged,
    this.leading,
    this.trailing,
    this.minTouchTargetSize,
  });

  bool get _selected => identityValue != null && identityValue == groupIdentityValue;

  @override
  State<Accordion<T>> createState() => _AccordionState<T>();
}

class _AccordionState<T> extends State<Accordion<T>> with TickerProviderStateMixin {
  final ColorTween _textColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();
  final ColorTween _hoverColorTween = ColorTween();

  late AccordionConfiguration _effectiveAccordionConfiguration;
  late BorderRadiusGeometry _effectiveBorderRadius;
  late EdgeInsetsGeometry _effectiveHeaderPadding;
  late EdgeInsets _resolvedDirectionalHeaderPadding;
  late double _effectiveHeaderHeight;

  Animation<Color?>? _textColor;
  Animation<Color?>? _iconColor;
  Animation<Color?>? _backgroundColor;
  Animation<Color?>? _hoverColor;
  AnimationController? _expansionAnimationController;
  AnimationController? _hoverAnimationController;
  CurvedAnimation? _expansionCurvedAnimation;
  FocusNode? _focusNode;
  Color? _effectiveHoverEffectColor;

  bool _isExpanded = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleActiveState(bool isActive) {
    isActive ? _hoverAnimationController!.forward() : _hoverAnimationController!.reverse();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expansionAnimationController!.forward();
        PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
        return;
      }
      _expansionAnimationController!.reverse().then<void>((void value) {
        if (!mounted) return;
        setState(() {});
      });
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });

    widget.onExpansionChanged?.call(_isExpanded ? widget.identityValue : null);
  }

  @override
  void initState() {
    super.initState();
    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ?? widget.initiallyExpanded || widget._selected;
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;
      if (_isExpanded) {
        _expansionAnimationController!.value = 1.0;
      }
    });
  }

  @override
  void didUpdateWidget(Accordion<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.identityValue == null && widget.groupIdentityValue == null) return;

    _isExpanded = widget._selected;

    setState(() {
      if (_isExpanded) {
        _expansionAnimationController!.forward();
        PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
        return;
      }

      _expansionAnimationController!.reverse().then<void>((void value) {
        if (!mounted) return;
        setState(() {});
      });
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
  }

  @override
  void dispose() {
    _expansionAnimationController!.dispose();
    _hoverAnimationController!.dispose();
    super.dispose();
  }

  Widget? _buildIcon(BuildContext context) {
    final iconSize = context.theme.accordionTheme().configuration.select(widget.size).iconSizeValue;
    final effectiveTrailingIconColor = widget.iconColor ?? context.theme.accordionTheme().style.trailingIconColor;
    final effectiveExpandedTrailingIconColor = widget.expandedIconColor ?? context.theme.accordionTheme().style.expandedTrailingIconColor;
    _iconColor ??= _iconColorTween.animate(_expansionCurvedAnimation!);
    _iconColorTween
      ..begin = effectiveTrailingIconColor
      ..end = effectiveExpandedTrailingIconColor;

    return IconTheme(
      data: IconThemeData(color: _iconColor?.value),
      child: RotationTransition(
        turns: Tween<double>(begin: 0.0, end: 0.5).animate(_expansionCurvedAnimation!),
        child: Icon(Icons.arrow_downward, size: iconSize),
      ),
    );
  }

  Widget _buildDecorationContainer({required Widget child}) => BaseControl(
        onTap: widget.disabled ? null : _handleTap,
        autofocus: widget.autofocus,
        minTouchTargetSize: widget.minTouchTargetSize ?? context.theme.accordionTheme().configuration.select(widget.size).minTouchTargetSize,
        focusNode: _effectiveFocusNode,
        builder: (context, isEnabled, isHovered, isFocused, isPressed) {
          final isActive = isHovered || isFocused;
          _handleActiveState(isActive);
          return child;
        },
      );

  Widget _buildContent(BuildContext context, Widget? rootChild) {
    _effectiveHoverEffectColor ??= context.theme.effectsTheme().hover.color;
    _effectiveAccordionConfiguration = context.theme.accordionTheme().configuration.select(widget.size);
    _effectiveBorderRadius = widget.borderRadius ?? _effectiveAccordionConfiguration.borderRadius;
    _effectiveHeaderHeight = widget.headerHeight ?? _effectiveAccordionConfiguration.headerHeight;
    _effectiveHeaderPadding = widget.headerPadding ?? _effectiveAccordionConfiguration.headerPadding;
    _resolvedDirectionalHeaderPadding = _effectiveHeaderPadding.resolve(Directionality.of(context));

    final effectiveBorderColor = widget.borderColor ?? context.theme.accordionTheme().style.borderColor;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.accordionTheme().style.backgroundColor;
    final effectiveExpandedBackgroundColor = widget.expandedBackgroundColor ?? context.theme.accordionTheme().style.expandedBackgroundColor;
    final effectiveIconColor = widget.iconColor ?? context.theme.accordionTheme().style.iconColor;
    final effectiveExpandedIconColor = widget.expandedIconColor ?? context.theme.accordionTheme().style.expandedIconColor;
    final effectiveTextColor = widget.textColor ?? context.theme.accordionTheme().style.textColor;
    final effectiveExpandedTextColor = widget.expandedTextColor ?? context.theme.accordionTheme().style.expandedTextColor;
    final effectiveContentTextColor = context.theme.accordionTheme().style.contentColor;
    final effectiveHeaderTextStyle = _effectiveAccordionConfiguration.headerTextStyle;
    final effectiveContentTextStyle = _effectiveAccordionConfiguration.contentTextStyle;
    final effectiveHoverEffectColor = context.theme.effectsTheme().hover.color;
    final effectiveHoverEffectDuration = context.theme.effectsTheme().hover.duration;
    final effectiveHoverEffectCurve = context.theme.effectsTheme().hover.curve;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.accordionTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.accordionTheme().style.transitionCurve;

    _expansionAnimationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);

    _expansionCurvedAnimation ??= CurvedAnimation(parent: _expansionAnimationController!, curve: effectiveTransitionCurve);

    _hoverAnimationController ??= AnimationController(duration: effectiveHoverEffectDuration, vsync: this);

    _backgroundColor ??= _backgroundColorTween.animate(_expansionCurvedAnimation!);
    _backgroundColorTween
      ..begin = effectiveBackgroundColor
      ..end = effectiveExpandedBackgroundColor;

    _hoverColor ??= _hoverAnimationController!.drive(_hoverColorTween.chain(CurveTween(curve: effectiveHoverEffectCurve)));
    _hoverColorTween
      ..begin = _backgroundColor!.value
      ..end = Color.alphaBlend(effectiveHoverEffectColor, _backgroundColor!.value!);

    _textColor ??= _textColorTween.animate(_expansionCurvedAnimation!);
    _textColorTween
      ..begin = effectiveTextColor
      ..end = effectiveExpandedTextColor;

    _iconColor ??= _iconColorTween.animate(_expansionCurvedAnimation!);
    _iconColorTween
      ..begin = effectiveIconColor
      ..end = effectiveExpandedIconColor;

    final Widget header = SizedBox(
      height: _effectiveHeaderHeight,
      child: Padding(
        padding: _resolvedDirectionalHeaderPadding,
        child: IconTheme(
          data: IconThemeData(color: _iconColor!.value),
          child: DefaultTextStyle(
            style: effectiveHeaderTextStyle.copyWith(color: _textColor!.value),
            child: Row(
              children: [
                if (widget.leading != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: widget.gap ?? _resolvedDirectionalHeaderPadding.left),
                    child: widget.leading,
                  ),
                Expanded(child: widget.label),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: widget.gap ?? _resolvedDirectionalHeaderPadding.right),
                  child: widget.trailing ?? _buildIcon(context)!,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final Widget childWrapper = ClipRect(
      child: IconTheme(
        data: IconThemeData(color: effectiveContentTextColor),
        child: DefaultTextStyle(
          style: effectiveContentTextStyle.copyWith(color: effectiveContentTextColor),
          child: Align(
            alignment: widget.expandedAlignment ?? Alignment.topCenter,
            heightFactor: _expansionCurvedAnimation!.value,
            child: rootChild,
          ),
        ),
      ),
    );

    return Semantics(
      label: widget.semanticLabel,
      enabled: _isExpanded,
      child: Container(
        width: widget.width,
        clipBehavior: widget.clipBehavior ?? Clip.none,
        decoration: ShapeDecoration(
          color: effectiveBackgroundColor,
          shape: SquircleBorder(
            side: widget.showBorder ? BorderSide(color: effectiveBorderColor) : BorderSide.none,
            borderRadius: _effectiveBorderRadius.squircle(context),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildDecorationContainer(child: header),
            childWrapper,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDividerColor = widget.dividerColor ?? context.theme.accordionTheme().style.dividerColor;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.accordionTheme().style.transitionDuration;
    _expansionAnimationController ??= AnimationController(duration: effectiveTransitionDuration, vsync: this);
    final isClosed = !_isExpanded && _expansionAnimationController!.isDismissed;
    final shouldRemoveChildren = isClosed && !widget.maintainState;
    final result = Offstage(
      offstage: isClosed,
      child: TickerMode(
        enabled: !isClosed,
        child: Column(
          children: [
            if (widget.showDivider) Container(height: 1, color: effectiveDividerColor),
            Padding(padding: widget.childrenPadding ?? EdgeInsets.zero, child: widget.child),
          ],
        ),
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _expansionAnimationController!.view,
        builder: _buildContent,
        child: shouldRemoveChildren ? null : result,
      ),
    );
  }
}
