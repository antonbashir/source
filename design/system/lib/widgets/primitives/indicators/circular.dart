import 'package:design/constants/indicators.dart';
import 'package:design/widgets/primitives/indicators/base.dart';
import 'package:design/painters/progress/circular.dart';
import 'package:flutter/widgets.dart';

class CircularProgressIndicator extends BaseProgressIndicator {
  final double strokeWidth;
  final StrokeCap strokeCap;

  const CircularProgressIndicator({
    required super.backgroundColor,
    required super.color,
    required this.strokeWidth,
    required this.strokeCap,
    super.key,
    super.value,
    super.valueColor,
    super.semanticsLabel,
    super.semanticsValue,
  });

  @override
  State<CircularProgressIndicator> createState() => _CircularProgressIndicatorState();
}

class _CircularProgressIndicatorState extends State<CircularProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: circularIndicatorIndeterminateDurationMilliseconds),
      vsync: this,
    );

    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(CircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
      return;
    }

    if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStaticProgressIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) =>
      widget.buildSemanticsWrapper(
        context: context,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: circularIndicatorMinSize,
            minHeight: circularIndicatorMinSize,
          ),
          child: RepaintBoundary(
            child: CustomPaint(
              painter: CircularProgressIndicatorPainter(
                backgroundColor: widget.backgroundColor,
                valueColor: widget.color,
                value: widget.value,
                headValue: headValue,
                tailValue: tailValue,
                offsetValue: offsetValue,
                rotationValue: rotationValue,
                strokeWidth: widget.strokeWidth,
                strokeCap: widget.strokeCap,
              ),
            ),
          ),
        ),
      );

  Widget _buildAnimation() => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => _buildStaticProgressIndicator(
          context,
          circularIndicatorStrokeHeadTween.evaluate(_controller),
          circularIndicatorStrokeTailTween.evaluate(_controller),
          circularIndicatorOffsetTween.evaluate(_controller),
          circularIndicatorRotationTween.evaluate(_controller),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) _buildStaticProgressIndicator(context, 0.0, 0.0, 0, 0.0);
    return _buildAnimation();
  }
}
