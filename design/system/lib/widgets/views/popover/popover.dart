import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/delays.dart';
import 'package:design/constants/popover.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/widgets/configurator/configurator.dart';
import 'package:design/widgets/selection/selection.dart';
import 'package:flutter/widgets.dart';

class Popover extends StatefulWidget {
  static final List<_PopoverState> _openedPopovers = [];

  final Widget child;
  final Widget content;
  final PopoverPosition position;
  final bool show;
  final double? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Decoration? decoration;
  final double? borderWidth;
  final double? distanceToTarget;
  final double? minHeight;
  final double? minWidth;
  final double? maxHeight;
  final double? maxWidth;
  final double? popoverMargin;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? popoverShadows;
  final RouteObserver<PageRoute<dynamic>>? routeObserver;
  final String? semanticLabel;
  final VoidCallback? onTapOutside;

  const Popover({
    super.key,
    required this.child,
    required this.content,
    required this.show,
    this.position = PopoverPosition.top,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.decoration,
    this.distanceToTarget,
    this.minHeight,
    this.minWidth,
    this.maxHeight,
    this.maxWidth,
    this.popoverMargin,
    this.transitionDuration,
    this.transitionCurve,
    this.contentPadding,
    this.popoverShadows,
    this.routeObserver,
    this.semanticLabel,
    this.onTapOutside,
  });

  static void _removeOtherPopovers(_PopoverState current) {
    if (_openedPopovers.isNotEmpty) {
      final openedPopovers = _openedPopovers.toList();
      for (final state in openedPopovers) {
        if (state == current) continue;
        state._clearOverlayEntry();
      }
    }
  }

  @override
  State<Popover> createState() => _PopoverState();

  static bool dismissAll() {
    if (_openedPopovers.isNotEmpty) {
      final List<_PopoverState> openedTooltips = _openedPopovers.toList();
      for (final _PopoverState state in openedTooltips) {
        if (state.mounted) {
          state._removePopover(immediately: true);
        }
      }
      return true;
    }
    return false;
  }

  static Widget hovering({
    required Widget content,
    required Widget child,
    bool trackContent = false,
    PopoverPosition position = PopoverPosition.top,
    double? margin,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    Color? borderColor,
    Decoration? decoration,
    double? borderWidth,
    double? distanceToTarget,
    double? minHeight,
    double? minWidth,
    double? maxHeight,
    double? maxWidth,
    double? popoverMargin,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
    List<BoxShadow>? popoverShadows,
    RouteObserver<PageRoute<dynamic>>? routeObserver,
    String? semanticLabel,
    VoidCallback? onTapOutside,
  }) =>
      _HoveringPopover(
          popover: (show, showPopover, hidePopover) => Popover(
                show: show,
                margin: margin,
                borderRadius: borderRadius,
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                decoration: decoration,
                borderWidth: borderWidth,
                distanceToTarget: distanceToTarget,
                minHeight: minHeight,
                minWidth: minWidth,
                maxHeight: maxHeight,
                maxWidth: maxWidth,
                popoverMargin: popoverMargin,
                transitionDuration: transitionDuration,
                transitionCurve: transitionCurve,
                contentPadding: contentPadding,
                popoverShadows: popoverShadows,
                routeObserver: routeObserver,
                semanticLabel: semanticLabel,
                onTapOutside: () => hidePopover(),
                position: position,
                content: MouseRegion(onExit: (_) => hidePopover(), child: content),
                child: MouseRegion(onEnter: (_) => showPopover(), onExit: trackContent ? (_) {} : (_) => hidePopover(), child: child),
              ));
}

class _PopoverState extends State<Popover> with RouteAware, SingleTickerProviderStateMixin {
  late final ObjectKey _regionKey = ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;
  OverlayEntry? _overlayEntry;
  bool _routeIsShowing = true;

  bool get shouldShowPopover => widget.show && _routeIsShowing;

  void _showPopover() {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _createOverlayContent());
    Overlay.of(context).insert(_overlayEntry!);
    Popover._openedPopovers.add(this);
    Popover._removeOtherPopovers(this);
    _animationController!.value = 0;
    _animationController!.forward();
  }

  void _updatePopover() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removePopover({bool immediately = false}) {
    if (immediately) {
      _clearOverlayEntry();
      return;
    }
    _animationController!.value = 1;
    _animationController!.reverse().then((value) => _clearOverlayEntry());
  }

  void _handleTapOutside() {
    widget.onTapOutside?.call();
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      Popover._openedPopovers.remove(this);
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  _PopoverPositionProperties _resolvePopoverPositionParameters({
    required double margin,
    required PopoverPosition popoverPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double popoverTargetGlobalLeft,
    required double popoverTargetGlobalCenter,
    required double popoverTargetGlobalRight,
  }) =>
      switch (popoverPosition) {
        PopoverPosition.top => _PopoverPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            popoverMaxWidth: overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - margin * 2,
          ),
        PopoverPosition.bottom => _PopoverPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            popoverMaxWidth: overlayWidth - ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() - margin * 2,
          ),
        PopoverPosition.left => _PopoverPositionProperties(
            offset: Offset(-distanceToTarget, 0),
            targetAnchor: Alignment.centerLeft,
            followerAnchor: Alignment.centerRight,
            popoverMaxWidth: popoverTargetGlobalLeft - distanceToTarget - margin,
          ),
        PopoverPosition.right => _PopoverPositionProperties(
            offset: Offset(distanceToTarget, 0),
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            popoverMaxWidth: overlayWidth - popoverTargetGlobalRight - distanceToTarget - margin,
          ),
        PopoverPosition.topLeft => _PopoverPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topRight,
            followerAnchor: Alignment.bottomRight,
            popoverMaxWidth: popoverTargetGlobalRight - margin,
          ),
        PopoverPosition.topRight => _PopoverPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topLeft,
            followerAnchor: Alignment.bottomLeft,
            popoverMaxWidth: overlayWidth - popoverTargetGlobalLeft - margin,
          ),
        PopoverPosition.bottomLeft => _PopoverPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            popoverMaxWidth: popoverTargetGlobalRight - margin,
          ),
        PopoverPosition.bottomRight => _PopoverPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            popoverMaxWidth: overlayWidth - popoverTargetGlobalLeft - margin,
          ),
        _ => throw AssertionError(popoverPositionAssertion(popoverPosition))
      };

  @override
  void didPush() {
    _routeIsShowing = true;
    if (shouldShowPopover) {
      _removePopover();
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (mounted) _showPopover();
      });
    }
  }

  @override
  void didPushNext() {
    _routeIsShowing = false;
    _removePopover();
  }

  @override
  Future<void> didPopNext() async {
    _routeIsShowing = true;
    if (shouldShowPopover) {
      _removePopover();
      await Future.delayed(smallDelay, () {
        if (mounted) _showPopover();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(Popover oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!_routeIsShowing) return;

      if (oldWidget.position != widget.position) {
        _removePopover(immediately: true);
        _showPopover();
        _updatePopover();
        return;
      }

      if (shouldShowPopover && _overlayEntry == null) {
        _showPopover();
        _updatePopover();
        return;
      }

      if (!shouldShowPopover && _overlayEntry != null) {
        _removePopover();
        _updatePopover();
        return;
      }

      _updatePopover();
    });
  }

  @override
  void deactivate() {
    if (_overlayEntry != null) _removePopover(immediately: true);
    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _removePopover(immediately: true);
    widget.routeObserver?.unsubscribe(this);
    super.dispose();
  }

  Widget _createOverlayContent() {
    PopoverPosition popoverPosition = widget.position;

    final effectiveBorderRadius = widget.borderRadius ?? context.theme.popoverTheme().configuration.borderRadius;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.popoverTheme().style.backgroundColor;
    final effectiveTextColor = context.theme.popoverTheme().style.textColor;
    final effectiveIconColor = context.theme.popoverTheme().style.iconColor;
    final effectiveTextStyle = context.theme.popoverTheme().configuration.textStyle;
    final effectiveDistanceToTarget = widget.distanceToTarget ?? context.theme.popoverTheme().configuration.distanceToTarget;
    final effectiveContentPadding = widget.contentPadding ?? context.theme.popoverTheme().configuration.contentPadding;
    final effectiveMargin = widget.margin ?? context.theme.popoverTheme().configuration.margin;
    final resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));
    final effectivePopoverShadows = widget.popoverShadows ?? context.theme.popoverTheme().style.shadows;
    final overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;
    final targetRenderBox = context.findRenderObject()! as RenderBox;
    final popoverTargetGlobalCenter = targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);
    final popoverTargetGlobalLeft = targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);
    final popoverTargetGlobalRight = targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (Directionality.of(context) == TextDirection.rtl || popoverPosition == PopoverPosition.horizontal || popoverPosition == PopoverPosition.vertical) {
      switch (popoverPosition) {
        case PopoverPosition.left:
          popoverPosition = PopoverPosition.right;
        case PopoverPosition.right:
          popoverPosition = PopoverPosition.left;
        case PopoverPosition.topLeft:
          popoverPosition = PopoverPosition.topRight;
        case PopoverPosition.topRight:
          popoverPosition = PopoverPosition.topLeft;
        case PopoverPosition.bottomLeft:
          popoverPosition = PopoverPosition.bottomRight;
        case PopoverPosition.bottomRight:
          popoverPosition = PopoverPosition.bottomLeft;
        case PopoverPosition.vertical:
          popoverPosition = popoverTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy ? PopoverPosition.bottom : PopoverPosition.top;
        case PopoverPosition.horizontal:
          popoverPosition = popoverTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx ? PopoverPosition.right : PopoverPosition.left;
        default:
          break;
      }
    }

    final popoverPositionParameters = _resolvePopoverPositionParameters(
      margin: effectiveMargin,
      popoverPosition: popoverPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      popoverTargetGlobalLeft: popoverTargetGlobalLeft.dx,
      popoverTargetGlobalCenter: popoverTargetGlobalCenter.dx,
      popoverTargetGlobalRight: popoverTargetGlobalRight.dx,
    );

    final effectiveDropdownWidth = widget.maxWidth != null ? widget.maxWidth! : popoverPositionParameters.popoverMaxWidth;

    return Semantics(
      label: widget.semanticLabel,
      child: UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: popoverPositionParameters.offset,
          followerAnchor: popoverPositionParameters.followerAnchor,
          targetAnchor: popoverPositionParameters.targetAnchor,
          child: TapRegion(
            groupId: _regionKey,
            behavior: HitTestBehavior.translucent,
            onTapOutside: (PointerDownEvent _) => _handleTapOutside(),
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: _curvedAnimation!,
                child: IconTheme(
                  data: IconThemeData(color: effectiveIconColor),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: widget.minHeight ?? 0,
                        maxHeight: widget.maxHeight ?? double.infinity,
                        minWidth: widget.minWidth ?? 0,
                        maxWidth: effectiveDropdownWidth,
                      ),
                      padding: resolvedContentPadding,
                      decoration: widget.decoration ??
                          ShapeDecoration(
                            color: effectiveBackgroundColor,
                            shadows: effectivePopoverShadows,
                            shape: SquircleBorder(
                              borderRadius: effectiveBorderRadius.squircle(context),
                              side: BorderSide(color: widget.borderColor ?? context.theme.popoverTheme().style.borderColor),
                            ),
                          ),
                      child: Directionality(
                        textDirection: Directionality.of(context),
                        child: Selectable(
                          enabled: Configurator.of(context).actionsConfiguration.enableSelection,
                          child: widget.content,
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

  @override
  Widget build(BuildContext context) {
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.popoverTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.popoverTheme().style.transitionCurve;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return TapRegion(
      groupId: _regionKey,
      behavior: HitTestBehavior.translucent,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}

class _HoveringPopover extends StatefulWidget {
  final Widget Function(bool show, VoidCallback shouldShow, VoidCallback shouldHide) popover;

  const _HoveringPopover({required this.popover});

  @override
  State<_HoveringPopover> createState() => _HoveringPopoverState();
}

class _HoveringPopoverState extends State<_HoveringPopover> {
  var _show = false;

  @override
  Widget build(BuildContext context) => widget.popover(_show, () => setState(() => _show = true), () => setState(() => _show = false));
}

class _PopoverPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double popoverMaxWidth;
  final Offset offset;

  _PopoverPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.popoverMaxWidth,
    required this.offset,
  });
}
