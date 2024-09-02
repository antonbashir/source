import 'package:design/constants/progresses.dart';
import 'package:design/widgets/primitives/indicators/base.dart';
import 'package:design/painters/progress/linear.dart';
import 'package:flutter/widgets.dart';

class LinearProgressIndicator extends BaseProgressIndicator {
  final bool active;
  final BorderRadiusGeometry containerRadius;
  final BorderRadiusGeometry progressRadius;
  final double minHeight;

  const LinearProgressIndicator({
    required super.backgroundColor,
    required super.color,
    required this.minHeight,
    required this.containerRadius,
    required this.progressRadius,
    this.active = true,
    super.key,
    super.value,
    super.valueColor,
    super.semanticsLabel,
    super.semanticsValue,
  }) : assert(minHeight > 0);

  @override
  State<LinearProgressIndicator> createState() => _LinearProgressIndicatorState();
}

class _LinearProgressIndicatorState extends State<LinearProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: paintingLinearProgressIndeterminateDuration),
      vsync: this,
    );

    if (widget.value == null) _controller.repeat();

    if (!widget.active) _controller.stop();
  }

  @override
  void didUpdateWidget(LinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
      return;
    }

    if ((widget.value != null || !widget.active) && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildStaticProgressIndicator(BuildContext context, double animationValue, TextDirection textDirection) {
    final resolvedContainerRadius = widget.containerRadius.resolve(Directionality.of(context));
    final resolvedProgressRadius = widget.progressRadius.resolve(Directionality.of(context));
    return widget.buildSemanticsWrapper(
      context: context,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: widget.minHeight,
        ),
        child: RepaintBoundary(
          child: CustomPaint(
            painter: LinearProgressIndicatorPainter(
              backgroundColor: widget.backgroundColor,
              valueColor: widget.color,
              value: widget.value,
              animationValue: animationValue,
              containerRadius: resolvedContainerRadius,
              progressRadius: resolvedProgressRadius,
              textDirection: textDirection,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    if (widget.value != null) {
      return buildStaticProgressIndicator(context, _controller.value, textDirection);
    }

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) => buildStaticProgressIndicator(context, _controller.value, textDirection),
    );
  }
}
