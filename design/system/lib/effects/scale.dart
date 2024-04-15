import 'package:flutter/widgets.dart';

class ScaleEffect extends StatefulWidget {
  final Widget child;
  final double downscaleBound;
  final double upscaleBound;
  final Duration duration;
  final Curve curve;
  final bool scaleUp;
  final bool scaleDown;

  const ScaleEffect({
    super.key,
    required this.duration,
    required this.curve,
    required this.upscaleBound,
    this.downscaleBound = 0,
    this.scaleUp = false,
    this.scaleDown = false,
    required this.child,
  });

  @override
  State createState() => _ScaleEffectState();
}

class _ScaleEffectState extends State<ScaleEffect> with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _upscaleController;
  late AnimationController _downscaleController;
  late CurvedAnimation _upscale;
  late CurvedAnimation _downscale;

  @override
  void initState() {
    _upscaleController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: widget.upscaleBound,
    )..addListener(() => setState(() {}));
    _downscaleController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: widget.downscaleBound,
    )..addListener(() => setState(() {}));
    _upscale = CurvedAnimation(parent: _upscaleController, curve: widget.curve);
    _downscale = CurvedAnimation(parent: _downscaleController, curve: widget.curve);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScaleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scaleDown != widget.scaleDown) {
      if (widget.scaleDown) {
        _upscaleController.reverse();
        _downscaleController.forward();
        return;
      }
      _downscaleController.reverse();
      return;
    }
    if (oldWidget.scaleUp != widget.scaleUp) {
      if (widget.scaleUp) {
        _upscaleController.forward();
        return;
      }
      _upscaleController.reverse();
      _downscaleController.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _upscaleController.dispose();
    _downscaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = widget.scaleDown
        ? 1 - _downscale.value
        : widget.scaleUp
            ? _downscaleController.isAnimating
                ? 1 - _downscale.value
                : 1 + _upscale.value
            : _downscaleController.isAnimating
                ? 1 - _downscale.value
                : _upscaleController.isAnimating
                    ? 1 + _upscale.value
                    : 1;
    return Transform.scale(
      scale: _scale,
      child: widget.child,
    );
  }
}
