import 'package:flutter/widgets.dart';

class ScaleDownNotifier with ChangeNotifier {
  void scaleDown() {
    notifyListeners();
  }
}

class ScaleEffect extends StatefulWidget {
  final Widget child;
  final double downscaleBound;
  final double upscaleBound;
  final Duration duration;
  final Curve curve;
  final bool scaleUp;
  final ScaleDownNotifier? scaleDown;

  const ScaleEffect({
    super.key,
    required this.duration,
    required this.curve,
    required this.upscaleBound,
    this.downscaleBound = 0,
    this.scaleUp = false,
    this.scaleDown,
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
      reverseDuration: widget.duration,
      lowerBound: 0,
      upperBound: widget.upscaleBound,
    )..addListener(() => setState(() {}));
    _downscaleController = AnimationController(
      vsync: this,
      reverseDuration: widget.duration,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: widget.downscaleBound,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _downscaleController.reverse();
      });
    _upscale = CurvedAnimation(parent: _upscaleController, curve: widget.curve, reverseCurve: widget.curve);
    _downscale = CurvedAnimation(parent: _downscaleController, curve: widget.curve, reverseCurve: widget.curve);
    widget.scaleDown?.addListener(() {
      _upscaleController.reverse();
      _downscaleController.forward();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScaleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scaleUp != widget.scaleUp) {
      if (widget.scaleUp) {
        _upscaleController.forward();
        _downscaleController.reverse();
        return;
      }
      _upscaleController.reverse();
    }
  }

  @override
  void dispose() {
    _upscaleController.dispose();
    _downscaleController.dispose();
    widget.scaleDown?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = (_downscaleController.isAnimating || _downscaleController.isCompleted)
        ? 1 - _downscale.value
        : (_upscaleController.isAnimating || _upscaleController.isCompleted)
            ? 1 + _upscale.value
            : 1;
    return Transform.scale(
      scale: _scale,
      child: widget.child,
    );
  }
}
