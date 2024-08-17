import 'package:design/painters/effects/focus.dart';
import 'package:flutter/widgets.dart';

class FocusEffect extends StatefulWidget {
  final bool show;
  final BorderRadiusGeometry? childBorderRadius;
  final Color effectColor;
  final double effectExtent;
  final Duration effectDuration;
  final Curve effectCurve;
  final Widget child;

  const FocusEffect({
    super.key,
    required this.show,
    this.childBorderRadius,
    required this.effectColor,
    required this.effectExtent,
    required this.effectDuration,
    required this.effectCurve,
    required this.child,
  });

  @override
  State<FocusEffect> createState() => _FocusEffectState();
}

class _FocusEffectState extends State<FocusEffect> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: widget.effectDuration,
  );

  late final CurvedAnimation _focusAnimation = CurvedAnimation(
    parent: _animationController,
    curve: widget.effectCurve,
  );

  @override
  void didUpdateWidget(FocusEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.show ? _animationController.forward() : _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBorderRadius = widget.childBorderRadius?.resolve(Directionality.of(context)) ?? BorderRadius.zero;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => CustomPaint(
        willChange: true,
        painter: FocusEffectPainter(
          color: widget.effectColor,
          effectExtent: widget.effectExtent,
          borderRadius: resolvedBorderRadius,
          animation: _focusAnimation,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
