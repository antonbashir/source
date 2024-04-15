import 'package:design/borders/squircle/border.dart';
import 'package:design/constants/assertions.dart';
import 'package:design/constants/delays.dart';
import 'package:design/constants/dropdown.dart';
import 'package:design/extensions/extensions.dart';
import 'package:design/theme/tokens/colors.dart';
import 'package:flutter/widgets.dart';

class Dropdown extends StatefulWidget {
  final bool constrainWidthToChild;
  final bool show;
  final Color borderColor;
  final Widget child;
  final Widget content;
  final DropdownAnchorPosition anchorPosition;
  final Alignment? followerAnchor;
  final Alignment? targetAnchor;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double borderWidth;
  final double? distanceToTarget;
  final double? minContentHeight;
  final double? minContentWidth;
  final double? maxContentHeight;
  final double? maxContentWidth;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? dropdownMargin;
  final List<BoxShadow>? dropdownShadows;
  final Offset? offset;
  final RouteObserver<PageRoute<dynamic>>? routeObserver;
  final String? groupId;
  final String? semanticLabel;
  final VoidCallback? onTapOutside;

  const Dropdown({
    super.key,
    this.constrainWidthToChild = false,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.anchorPosition = DropdownAnchorPosition.bottom,
    required this.show,
    required this.child,
    required this.content,
    this.followerAnchor,
    this.targetAnchor,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.distanceToTarget,
    this.minContentHeight,
    this.minContentWidth,
    this.maxContentHeight,
    this.maxContentWidth,
    this.transitionDuration,
    this.transitionCurve,
    this.contentPadding,
    this.dropdownMargin,
    this.dropdownShadows,
    this.offset,
    this.routeObserver,
    this.groupId,
    this.semanticLabel,
    this.onTapOutside,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> with RouteAware, SingleTickerProviderStateMixin {
  late final Key _regionKey = widget.groupId != null ? ValueKey(widget.groupId) : ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;
  OverlayEntry? _overlayEntry;

  bool _routeIsShowing = true;
  bool get shouldShowDropdown => widget.show && _routeIsShowing;

  void _showDropdown() {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _createOverlayContent());
    Overlay.of(context).insert(_overlayEntry!);
    _animationController!.value = 0;
    _animationController!.forward();
  }

  void _updateDropdown() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeDropdown({bool immediately = false}) {
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
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  _DropdownPositionProperties _resolveDropdownPositionParameters({
    required DropdownAnchorPosition dropdownAnchorPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double dropdownTargetGlobalLeft,
    required double dropdownTargetGlobalCenter,
    required double dropdownTargetGlobalRight,
    required EdgeInsets dropdownMargin,
  }) =>
      switch (dropdownAnchorPosition) {
        DropdownAnchorPosition.top => _DropdownPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            dropdownMaxWidth: overlayWidth - ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() - dropdownMargin.horizontal,
          ),
        DropdownAnchorPosition.bottom => _DropdownPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            dropdownMaxWidth: overlayWidth - ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() - dropdownMargin.horizontal,
          ),
        DropdownAnchorPosition.left => _DropdownPositionProperties(
            offset: Offset(-distanceToTarget, 0),
            targetAnchor: Alignment.centerLeft,
            followerAnchor: Alignment.centerRight,
            dropdownMaxWidth: dropdownTargetGlobalLeft - distanceToTarget - dropdownMargin.left,
          ),
        DropdownAnchorPosition.right => _DropdownPositionProperties(
            offset: Offset(distanceToTarget, 0),
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            dropdownMaxWidth: overlayWidth - dropdownTargetGlobalRight - distanceToTarget - dropdownMargin.right,
          ),
        DropdownAnchorPosition.topLeft => _DropdownPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topLeft,
            followerAnchor: Alignment.bottomLeft,
            dropdownMaxWidth: overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
          ),
        DropdownAnchorPosition.topRight => _DropdownPositionProperties(
            offset: Offset(0, -distanceToTarget),
            targetAnchor: Alignment.topRight,
            followerAnchor: Alignment.bottomRight,
            dropdownMaxWidth: dropdownTargetGlobalRight - dropdownMargin.right,
          ),
        DropdownAnchorPosition.bottomLeft => _DropdownPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            dropdownMaxWidth: overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
          ),
        DropdownAnchorPosition.bottomRight => _DropdownPositionProperties(
            offset: Offset(0, distanceToTarget),
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            dropdownMaxWidth: dropdownTargetGlobalRight - dropdownMargin.right,
          ),
        _ => throw AssertionError(dropdownPositionAssertion(dropdownAnchorPosition))
      };

  @override
  void didPush() {
    _routeIsShowing = true;
    if (shouldShowDropdown) {
      _removeDropdown();
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted) return;
        _showDropdown();
      });
    }
  }

  @override
  void didPushNext() {
    _routeIsShowing = false;
    _removeDropdown();
  }

  @override
  Future<void> didPopNext() async {
    _routeIsShowing = true;
    if (shouldShowDropdown) {
      _removeDropdown();
      await Future.delayed(smallDelay, () {
        if (mounted) _showDropdown();
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
  void didUpdateWidget(Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_routeIsShowing) return;

      if (oldWidget.anchorPosition != widget.anchorPosition) {
        _removeDropdown(immediately: true);
        _showDropdown();
        _updateDropdown();
        return;
      }

      if (shouldShowDropdown && _overlayEntry == null) {
        _showDropdown();
        _updateDropdown();
        return;
      }

      if (!shouldShowDropdown && _overlayEntry != null) {
        _removeDropdown();
        _updateDropdown();
        return;
      }

      _updateDropdown();
    });
  }

  @override
  void deactivate() {
    if (_overlayEntry != null) _removeDropdown(immediately: true);
    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _removeDropdown(immediately: true);
    widget.routeObserver?.unsubscribe(this);
    super.dispose();
  }

  Widget _createOverlayContent() {
    final effectiveBorderRadius = widget.borderRadius ?? context.theme.dropdownTheme().configuration.borderRadius;
    final effectiveBackgroundColor = widget.backgroundColor ?? context.theme.dropdownTheme().style.backgroundColor;
    final effectiveTextColor = context.theme.dropdownTheme().style.textColor;
    final effectiveIconColor = context.theme.dropdownTheme().style.iconColor;
    final effectiveTextStyle = context.theme.dropdownTheme().configuration.textStyle;
    final effectiveDistanceToTarget = widget.distanceToTarget ?? context.theme.dropdownTheme().configuration.distanceToTarget;
    final effectiveContentPadding = widget.contentPadding ?? context.theme.dropdownTheme().configuration.contentPadding;
    final resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));
    final effectiveDropdownMargin = widget.dropdownMargin ?? context.theme.dropdownTheme().configuration.dropdownMargin;
    final resolvedDropdownMargin = effectiveDropdownMargin.resolve(Directionality.of(context));
    final effectiveDropdownShadows = widget.dropdownShadows ?? context.theme.dropdownTheme().style.shadows;
    final overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;
    final targetRenderBox = context.findRenderObject()! as RenderBox;
    final dropdownTargetGlobalCenter = targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);
    final dropdownTargetGlobalLeft = targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);
    final dropdownTargetGlobalRight = targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    var dropdownAnchorPosition = widget.anchorPosition;
    if (Directionality.of(context) == TextDirection.rtl || dropdownAnchorPosition == DropdownAnchorPosition.horizontal || dropdownAnchorPosition == DropdownAnchorPosition.vertical) {
      switch (dropdownAnchorPosition) {
        case DropdownAnchorPosition.left:
          dropdownAnchorPosition = DropdownAnchorPosition.right;
        case DropdownAnchorPosition.right:
          dropdownAnchorPosition = DropdownAnchorPosition.left;
        case DropdownAnchorPosition.topLeft:
          dropdownAnchorPosition = DropdownAnchorPosition.topRight;
        case DropdownAnchorPosition.topRight:
          dropdownAnchorPosition = DropdownAnchorPosition.topLeft;
        case DropdownAnchorPosition.bottomLeft:
          dropdownAnchorPosition = DropdownAnchorPosition.bottomRight;
        case DropdownAnchorPosition.bottomRight:
          dropdownAnchorPosition = DropdownAnchorPosition.bottomLeft;
        case DropdownAnchorPosition.vertical:
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy ? DropdownAnchorPosition.bottom : DropdownAnchorPosition.top;
        case DropdownAnchorPosition.horizontal:
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx ? DropdownAnchorPosition.right : DropdownAnchorPosition.left;
        default:
          break;
      }
    }

    final dropdownAnchorPositionParameters = _resolveDropdownPositionParameters(
      dropdownAnchorPosition: dropdownAnchorPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      dropdownTargetGlobalLeft: dropdownTargetGlobalLeft.dx,
      dropdownTargetGlobalCenter: dropdownTargetGlobalCenter.dx,
      dropdownTargetGlobalRight: dropdownTargetGlobalRight.dx,
      dropdownMargin: resolvedDropdownMargin,
    );

    final targetWidth = targetRenderBox.size.width;

    final effectiveDropdownWidth = widget.constrainWidthToChild
        ? targetWidth
        : widget.maxContentWidth != null
            ? widget.maxContentWidth!
            : dropdownAnchorPositionParameters.dropdownMaxWidth;

    return Semantics(
      label: widget.semanticLabel,
      child: UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: widget.offset ?? dropdownAnchorPositionParameters.offset,
          followerAnchor: widget.followerAnchor ?? dropdownAnchorPositionParameters.followerAnchor,
          targetAnchor: widget.targetAnchor ?? dropdownAnchorPositionParameters.targetAnchor,
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
                        minHeight: widget.minContentHeight ?? 0,
                        maxHeight: widget.maxContentHeight ?? double.infinity,
                        minWidth: widget.minContentWidth ?? 0,
                        maxWidth: effectiveDropdownWidth,
                      ),
                      padding: resolvedContentPadding,
                      decoration: widget.decoration ??
                          ShapeDecoration(
                            color: effectiveBackgroundColor,
                            shadows: effectiveDropdownShadows,
                            shape: SquircleBorder(
                              borderRadius: effectiveBorderRadius.squircle(context),
                              side: BorderSide(color: widget.borderColor),
                            ),
                          ),
                      child: Directionality(
                        textDirection: Directionality.of(context),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.dropdownTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.dropdownTheme().style.transitionCurve;

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

class _DropdownPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double dropdownMaxWidth;
  final Offset offset;

  _DropdownPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.dropdownMaxWidth,
    required this.offset,
  });
}
