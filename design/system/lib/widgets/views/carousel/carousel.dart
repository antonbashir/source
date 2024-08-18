import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:design/constants/keys.dart';
import 'package:design/extensions/extensions.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class Carousel extends StatefulWidget {
  final Axis axisDirection;
  final bool autoPlay;
  final bool isCentered;
  final bool clampMaxExtent;
  final bool loop;
  final double anchor;
  final double itemExtent;
  final double velocityFactor;
  final int itemCount;
  final Widget Function(BuildContext context, int itemIndex, int realIndex) itemBuilder;
  final double? height;
  final double? width;
  final double? gap;
  final Duration? autoPlayDelay;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final void Function(int index)? onIndexChanged;

  const Carousel({
    super.key,
    this.axisDirection = Axis.horizontal,
    this.autoPlay = false,
    this.isCentered = true,
    this.clampMaxExtent = false,
    this.loop = false,
    this.anchor = 0.0,
    this.velocityFactor = 0.5,
    required this.itemExtent,
    required this.itemCount,
    this.gap,
    this.height,
    this.width,
    this.autoPlayDelay,
    this.transitionDuration,
    this.transitionCurve,
    this.controller,
    this.physics,
    this.scrollBehavior,
    this.onIndexChanged,
    required this.itemBuilder,
  })  : assert(itemExtent > 0),
        assert(itemCount > 0),
        assert(velocityFactor > 0.0 && velocityFactor <= 1.0);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late int _lastReportedItemIndex;
  late CarouselScrollController _scrollController;

  final Key _forwardListKey = const ValueKey<String>(carouselKey);

  double _effectiveGap = 0;

  double _getCenteredAnchor(BoxConstraints constraints) {
    if (!widget.isCentered) return widget.anchor;
    final maxExtent = widget.axisDirection == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
    return ((maxExtent / 2) - (widget.itemExtent / 2)) / maxExtent;
  }

  bool _clampMaxExtent(double viewportWidth) {
    final itemsWidth = widget.itemCount * widget.itemExtent;
    final gapWidth = (widget.itemCount - 1) * _effectiveGap;
    final anchor = viewportWidth * widget.anchor * 2;
    final totalWidth = itemsWidth + gapWidth + anchor;
    return totalWidth >= viewportWidth && widget.clampMaxExtent;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.axisDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final textDirection = Directionality.of(context);
        final axisDirection = textDirectionToAxisDirection(textDirection);
        return axisDirection;
      case Axis.vertical:
        return AxisDirection.down;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = (widget.controller as CarouselScrollController?) ?? CarouselScrollController();
    _lastReportedItemIndex = _scrollController.initialItem;
    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        final effectiveAutoPlayDelay = widget.autoPlayDelay ?? context.theme.carouselTheme().style.autoPlayDelay;
        final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.carouselTheme().style.transitionDuration;
        final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.carouselTheme().style.transitionCurve;
        _scrollController.startAutoPlay(
          context,
          delay: effectiveAutoPlayDelay,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        );
      });
    }
  }

  @override
  void didUpdateWidget(Carousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoPlay != oldWidget.autoPlay) {
      if (widget.autoPlay) {
        final effectiveAutoPlayDelay = widget.autoPlayDelay ?? context.theme.carouselTheme().style.autoPlayDelay;
        final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.carouselTheme().style.transitionDuration;
        final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.carouselTheme().style.transitionCurve;
        _scrollController.startAutoPlay(
          context,
          delay: effectiveAutoPlayDelay,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        );
        return;
      }
      _scrollController.stopAutoPlay();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _buildSlivers(BuildContext context, {required AxisDirection axisDirection}) {
    final resolvedPadding = widget.axisDirection == Axis.horizontal ? EdgeInsetsDirectional.only(end: _effectiveGap) : EdgeInsetsDirectional.only(bottom: _effectiveGap);
    final childDelegate = SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: resolvedPadding,
        child: widget.itemBuilder(context, index.abs() % widget.itemCount, index),
      ),
      childCount: widget.loop ? null : widget.itemCount,
    );

    final reversedChildDelegate = widget.loop
        ? SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: resolvedPadding,
              child: widget.itemBuilder(context, widget.itemCount - (index.abs() % widget.itemCount) - 1, -(index + 1)),
            ),
          )
        : null;

    final forward = SliverFixedExtentList(
      key: _forwardListKey,
      delegate: childDelegate,
      itemExtent: widget.itemExtent + _effectiveGap,
    );

    if (!widget.loop) return [forward];

    final reversed = SliverFixedExtentList(
      delegate: reversedChildDelegate!,
      itemExtent: widget.itemExtent + _effectiveGap,
    );

    return [reversed, forward];
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = context.theme.carouselTheme().style.textColor;
    final effectiveIconColor = context.theme.carouselTheme().style.iconColor;
    final effectiveTextStyle = context.theme.carouselTheme().configuration.textStyle;
    final axisDirection = _getDirection(context);
    final effectiveScrollBehavior = widget.scrollBehavior ??
        ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        );

    _effectiveGap = widget.gap ?? context.theme.carouselTheme().configuration.gap;

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics as CarouselExtentMetrics;
          final currentItem = metrics.itemIndex;
          if (currentItem != _lastReportedItemIndex) {
            _lastReportedItemIndex = currentItem;
            final trueIndex = _getTrueIndex(_lastReportedItemIndex, widget.itemCount);
            if (widget.onIndexChanged != null) {
              widget.onIndexChanged!(trueIndex);
            }
          }
          return false;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final centeredAnchor = _getCenteredAnchor(constraints);
            final clampMaxExtent = _clampMaxExtent(constraints.maxWidth);
            return IconTheme(
              data: IconThemeData(
                color: effectiveIconColor,
              ),
              child: DefaultTextStyle(
                style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                child: _CarouselScrollable(
                  anchor: centeredAnchor,
                  axisDirection: axisDirection,
                  controller: _scrollController,
                  clampMaxExtent: clampMaxExtent,
                  gap: _effectiveGap,
                  itemCount: widget.itemCount,
                  itemExtent: widget.itemExtent + _effectiveGap,
                  loop: widget.loop,
                  physics: widget.physics ?? const CarouselScrollPhysics(),
                  scrollBehavior: effectiveScrollBehavior,
                  velocityFactor: widget.velocityFactor,
                  viewportBuilder: (context, position) => Viewport(
                    anchor: centeredAnchor,
                    axisDirection: axisDirection,
                    center: _forwardListKey,
                    offset: position,
                    slivers: _buildSlivers(context, axisDirection: axisDirection),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CarouselScrollable extends Scrollable {
  final bool clampMaxExtent;
  final bool loop;
  final double anchor;
  final double gap;
  final double itemExtent;
  final double velocityFactor;
  final int itemCount;

  const _CarouselScrollable({
    super.axisDirection = AxisDirection.right,
    super.controller,
    super.physics,
    super.scrollBehavior,
    required super.viewportBuilder,
    required this.clampMaxExtent,
    required this.loop,
    required this.anchor,
    required this.gap,
    required this.itemExtent,
    required this.velocityFactor,
    required this.itemCount,
  });

  @override
  _CarouselScrollableState createState() => _CarouselScrollableState();
}

class _CarouselScrollableState extends ScrollableState {
  bool get clampMaxExtent => (widget as _CarouselScrollable).clampMaxExtent;
  bool get loop => (widget as _CarouselScrollable).loop;
  double get anchor => (widget as _CarouselScrollable).anchor;
  double get gap => (widget as _CarouselScrollable).gap;
  double get itemExtent => (widget as _CarouselScrollable).itemExtent;
  double get velocityFactor => (widget as _CarouselScrollable).velocityFactor;
  int get itemCount => (widget as _CarouselScrollable).itemCount;
}

class CarouselScrollController extends ScrollController {
  final int initialItem;
  Timer? _autoPlayTimer;

  CarouselScrollController({this.initialItem = 0});

  void startAutoPlay(BuildContext context, {required Duration delay, required Duration duration, required Curve curve}) {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(delay, (timer) {
      if (offset >= position.maxScrollExtent && !position.outOfRange) {
        animateToItem(0, duration, curve: curve);
        return;
      }
      nextItem(duration, curve: curve);
    });
  }

  void stopAutoPlay() => _autoPlayTimer?.cancel();

  @override
  void dispose() {
    stopAutoPlay();
    super.dispose();
  }

  int get selectedItem => _getTrueIndex(
        (position as _CarouselScrollPosition).itemIndex,
        (position as _CarouselScrollPosition).itemCount,
      );

  Future<void> animateToItem(int itemIndex, Duration duration, {Curve? curve}) async {
    if (!hasClients) return;
    await Future.wait<void>([
      for (final position in positions.cast<_CarouselScrollPosition>())
        position.animateTo(
          itemIndex * position.itemExtent,
          duration: duration,
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  void jumpToItem(int itemIndex) {
    for (final position in positions.cast<_CarouselScrollPosition>()) {
      position.jumpTo(itemIndex * position.itemExtent);
    }
  }

  Future<void> nextItem(Duration duration, {Curve? curve}) async {
    if (!hasClients) return;
    await Future.wait<void>([
      for (final position in positions.cast<_CarouselScrollPosition>())
        position.animateTo(
          offset + position.itemExtent,
          duration: duration,
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  Future<void> previousItem(Duration duration, {Curve? curve}) async {
    if (!hasClients) return;
    await Future.wait<void>([
      for (final position in positions.cast<_CarouselScrollPosition>())
        position.animateTo(
          offset - position.itemExtent,
          duration: duration,
          curve: curve ?? Curves.fastOutSlowIn,
        ),
    ]);
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) => _CarouselScrollPosition(
        context: context,
        initialItem: initialItem,
        oldPosition: oldPosition,
        physics: physics,
      );
}

class CarouselExtentMetrics extends FixedScrollMetrics {
  final int itemIndex;

  CarouselExtentMetrics({
    required super.minScrollExtent,
    required super.maxScrollExtent,
    required super.pixels,
    required super.viewportDimension,
    required super.axisDirection,
    required super.devicePixelRatio,
    required this.itemIndex,
  });

  @override
  CarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) =>
      CarouselExtentMetrics(
        axisDirection: axisDirection ?? this.axisDirection,
        devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
        minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : 0.0),
        maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
        pixels: pixels ?? this.pixels,
        viewportDimension: viewportDimension ?? this.viewportDimension,
        itemIndex: itemIndex ?? this.itemIndex,
      );
}

int _getItemFromOffset({
  required double itemExtent,
  required double minScrollExtent,
  required double maxScrollExtent,
  required double offset,
}) =>
    (_clipOffsetToScrollableRange(offset, minScrollExtent, maxScrollExtent) / itemExtent).round();

double _clipOffsetToScrollableRange(double offset, double minScrollExtent, double maxScrollExtent) => math.min(math.max(offset, minScrollExtent), maxScrollExtent);

int _getTrueIndex(int currentIndex, int totalCount) {
  if (currentIndex >= 0) return currentIndex % totalCount;
  return (totalCount + (currentIndex % totalCount)) % totalCount;
}

class _CarouselScrollPosition extends ScrollPositionWithSingleContext implements CarouselExtentMetrics {
  _CarouselScrollPosition({
    required super.physics,
    required super.context,
    required int initialItem,
    super.oldPosition,
  })  : assert(context is _CarouselScrollableState),
        super(initialPixels: _getItemExtentFromScrollContext(context) * initialItem);

  double get anchor => _getAnchorFromScrollContext(context);
  static double _getAnchorFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).anchor;

  double get itemExtent => _getItemExtentFromScrollContext(context);
  static double _getItemExtentFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).itemExtent;

  double get gap => _getGapFromScrollContext(context);
  static double _getGapFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).gap;

  int get itemCount => _getItemCountFromScrollContext(context);
  static int _getItemCountFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).itemCount;

  bool get clampMaxExtent => _getDeferMaxExtentFromScrollContext(context);
  static bool _getDeferMaxExtentFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).clampMaxExtent;

  bool get loop => _getLoopFromScrollContext(context);
  static bool _getLoopFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).loop;

  double get velocityFactor => _getVelocityFactorFromScrollContext(context);
  static double _getVelocityFactorFromScrollContext(ScrollContext context) => (context as _CarouselScrollableState).velocityFactor;

  @override
  int get itemIndex => _getItemFromOffset(
        itemExtent: itemExtent,
        minScrollExtent: hasContentDimensions ? minScrollExtent : 0.0,
        maxScrollExtent: maxScrollExtent,
        offset: pixels,
      );

  @override
  double get maxScrollExtent {
    if (loop) {
      return super.hasContentDimensions ? super.maxScrollExtent : 0.0;
    }
    if (clampMaxExtent) {
      final itemsToSubtract = viewportDimension ~/ itemExtent;
      final remainderOfViewport = viewportDimension % itemExtent;
      final anchorWhitespaceFactor = viewportDimension * anchor * 2;
      return itemExtent * (itemCount - itemsToSubtract) - remainderOfViewport + anchorWhitespaceFactor - gap;
    }
    return itemExtent * (itemCount - 1);
  }

  @override
  CarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) =>
      CarouselExtentMetrics(
        axisDirection: axisDirection ?? this.axisDirection,
        devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
        minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : 0.0),
        maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
        pixels: pixels ?? this.pixels,
        viewportDimension: viewportDimension ?? this.viewportDimension,
        itemIndex: itemIndex ?? this.itemIndex,
      );
}

class CarouselScrollPhysics extends ScrollPhysics {
  const CarouselScrollPhysics({super.parent});

  @override
  CarouselScrollPhysics applyTo(ScrollPhysics? ancestor) => CarouselScrollPhysics(parent: buildParent(ancestor));

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final metrics = position as _CarouselScrollPosition;

    if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) || (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    final testFrictionSimulation = super.createBallisticSimulation(
      metrics,
      velocity * math.min(metrics.velocityFactor + 0.15, 1.0),
    );

    if (testFrictionSimulation != null && (testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent || testFrictionSimulation.x(double.infinity) == metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    final settlingItemIndex = _getItemFromOffset(
      itemExtent: metrics.itemExtent,
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      offset: testFrictionSimulation?.x(double.infinity) ?? metrics.pixels,
    );

    final settlingPixels = settlingItemIndex * metrics.itemExtent;

    final tolerance = toleranceFor(metrics);

    if (velocity.abs() < tolerance.velocity && (settlingPixels - metrics.pixels).abs() < tolerance.distance) {
      return null;
    }

    if (settlingItemIndex == metrics.itemIndex) {
      return SpringSimulation(
        spring,
        metrics.pixels,
        settlingPixels,
        velocity * metrics.velocityFactor,
        tolerance: tolerance,
      );
    }

    return FrictionSimulation.through(
      metrics.pixels,
      settlingPixels,
      velocity * metrics.velocityFactor,
      tolerance.velocity * metrics.velocityFactor * velocity.sign,
    );
  }
}
