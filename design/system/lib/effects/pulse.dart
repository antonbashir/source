import 'package:design/constants/effects.dart';
import 'package:design/painters/effects/pulse.dart';
import 'package:flutter/widgets.dart';

class PulseEffect extends StatefulWidget {
  final bool show;
  final bool showJiggle;
  final Color effectColor;
  final double effectExtent;
  final Duration effectDuration;
  final Curve effectCurve;
  final Widget child;
  final BorderRadiusGeometry? childBorderRadius;

  const PulseEffect({
    super.key,
    required this.show,
    required this.showJiggle,
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
    required this.child,
    this.childBorderRadius,
  });

  @override
  State<PulseEffect> createState() => _PulseEffectState();
}

class _PulseEffectState extends State<PulseEffect> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: widget.effectDuration,
  );

  late final _pulseAnimation = CurvedAnimation(
    parent: _animationController,
    curve: widget.effectCurve,
  );

  late final _jiggleAnimation = TweenSequence<double>(
    [
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: pulseJiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: pulseJiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.0),
        weight: pulseJiggleRestTimePercentage,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -1.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: pulseJiggleRestTimePercentage / 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -1.0, end: 0.0).chain(CurveTween(curve: widget.effectCurve)),
        weight: pulseJiggleRestTimePercentage / 2,
      ),
    ],
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
    if (widget.show) _animationController.repeat();
  }

  @override
  void didUpdateWidget(covariant PulseEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show != oldWidget.show) {
      if (widget.show) {
        _animationController.repeat();
        return;
      }
      _animationController.forward().then((_) => _animationController.reset());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform.translate(
          offset: Offset(widget.showJiggle ? _jiggleAnimation.value : 0.0, 0.0),
          child: CustomPaint(
            isComplex: true,
            willChange: true,
            painter: PulseEffectPainter(
              color: widget.effectColor,
              effectExtent: widget.effectExtent,
              borderRadius: widget.childBorderRadius?.resolve(Directionality.of(context)) ?? BorderRadius.zero,
              animation: _pulseAnimation,
            ),
            child: child,
          ),
        ),
        child: widget.child,
      );
}
