import 'package:design/constants/shrink.dart';
import 'package:flutter/widgets.dart';

class ShrinkContainer extends StatefulWidget {
  final Widget child;
  final double lowerBound;
  final double upperBound;
  final Duration duration;
  final Clip clipBehavior;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final AlignmentGeometry? transformAlignment;

  const ShrinkContainer({
    super.key,
    this.duration = shrinkContainerDuration,
    this.lowerBound = shrinkContainerLowerBound,
    this.upperBound = shrinkContainerUpperBound,
    this.clipBehavior = Clip.none,
    this.decoration,
    this.height,
    this.width,
    this.onTap,
    this.margin,
    this.padding,
    this.alignment,
    this.color,
    this.foregroundDecoration,
    this.constraints,
    this.transformAlignment,
    required this.child,
  });

  @override
  State createState() => _ShrinkContainerState();
}

class _ShrinkContainerState extends State<ShrinkContainer> with TickerProviderStateMixin {
  double? _scale;
  AnimationController? _upscaleController;
  AnimationController? _downscaleController;
  bool _upscale = false;

  @override
  void initState() {
    _upscaleController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
    )..addListener(() => setState(() {}));
    _downscaleController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
    )..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _upscaleController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = _upscale ? 1 + _upscaleController!.value : 1 - _downscaleController!.value;
    final controller = _upscale ? _upscaleController : _downscaleController;
    return MouseRegion(
      onEnter: (_) => _mouseEnter(),
      onExit: (_) => _mouseExit(),
      child: GestureDetector(
        onTapCancel: () {
          if (controller?.status == AnimationStatus.forward || controller?.status == AnimationStatus.completed) {
            _tapUp(null);
          }
        },
        onTapDown: _tapDown,
        onTap: widget.onTap,
        onTapUp: _tapUp,
        child: Transform.scale(
          scale: _scale,
          child: Container(
              alignment: widget.alignment,
              margin: widget.margin,
              padding: widget.padding,
              height: widget.height,
              width: widget.width,
              color: widget.color,
              foregroundDecoration: widget.foregroundDecoration,
              decoration: widget.decoration,
              constraints: widget.constraints,
              transformAlignment: widget.transformAlignment,
              clipBehavior: widget.clipBehavior,
              child: widget.child),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _upscale = false;
    _downscaleController!.forward();
  }

  void _tapUp(TapUpDetails? tapUpDetails) {
    _upscale = false;
    _downscaleController!.reverse();
  }

  void _mouseEnter() {
    _upscale = true;
    _upscaleController!.forward();
  }

  void _mouseExit() {
    if (_upscale) {
      _upscaleController!.reverse();
      return;
    }
    _upscaleController!.reset();
  }
}
