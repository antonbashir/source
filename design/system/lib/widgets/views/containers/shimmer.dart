library shimmer;

import 'package:design/constants/shimmer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

@immutable
class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final Gradient gradient;
  final int iterations;
  final bool enabled;

  const Shimmer({
    super.key,
    required this.child,
    required this.gradient,
    this.direction = ShimmerDirection.leftToRight,
    this.period = const Duration(milliseconds: 1500),
    this.iterations = 0,
    this.enabled = true,
  });

  Shimmer.fromColors({
    super.key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.leftToRight,
    this.iterations = 0,
    this.enabled = true,
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[baseColor, baseColor, highlightColor, baseColor, baseColor],
          stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
        );

  @override
  State<Shimmer> createState() => _ShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient, defaultValue: null));
    properties.add(EnumProperty<ShimmerDirection>('direction', direction));
    properties.add(DiagnosticsProperty<Duration>('period', period, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<int>('loop', iterations, defaultValue: 0));
  }
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)..addStatusListener(_animate);
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animate);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    if (widget.enabled) {
      _controller.forward();
      super.didUpdateWidget(oldWidget);
      return;
    }
    _controller.stop();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (BuildContext context, Widget? child) => _Shimmer(
          direction: widget.direction,
          gradient: widget.gradient,
          percent: _controller.value,
          child: child,
        ),
      );

  void _animate(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    _count++;
    if (widget.iterations <= 0) {
      _controller.repeat();
      return;
    }

    if (_count < widget.iterations) {
      _controller.forward(from: 0.0);
    }
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerDirection direction;
  final Gradient gradient;

  const _Shimmer({
    super.child,
    required this.percent,
    required this.direction,
    required this.gradient,
  });

  @override
  _ShimmerFilter createRenderObject(BuildContext context) => _ShimmerFilter(percent, direction, gradient);

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  ShimmerDirection _direction;
  Gradient _gradient;
  double _percent;

  _ShimmerFilter(this._percent, this._direction, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  set direction(ShimmerDirection newDirection) {
    if (newDirection == _direction) {
      return;
    }
    _direction = newDirection;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      layer = null;
      return;
    }
    assert(needsCompositing);
    final double width = child!.size.width;
    final double height = child!.size.height;
    Rect rect;
    double dx, dy;
    switch (_direction) {
      case ShimmerDirection.rightToLeft:
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      case ShimmerDirection.topToBottom:
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      case ShimmerDirection.bottomToTop:
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      default:
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
    }
    layer ??= ShaderMaskLayer();
    layer!
      ..shader = _gradient.createShader(rect)
      ..maskRect = offset & size
      ..blendMode = BlendMode.srcIn;
    context.pushLayer(layer!, super.paint, offset);
  }

  double _offset(double start, double end, double percent) => start + (end - start) * percent;
}
