import 'package:design/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

class DotsIndicator extends StatefulWidget {
  final int selected;
  final int count;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? gap;
  final double? size;
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  const DotsIndicator({
    super.key,
    required this.selected,
    required this.count,
    this.selectedColor,
    this.unselectedColor,
    this.gap,
    this.size,
    this.transitionDuration,
    this.transitionCurve,
  });

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> with TickerProviderStateMixin {
  final ColorTween _dotColorTween = ColorTween();

  List<AnimationController>? _animationControllers;
  List<Animation<Color?>>? _animations;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      _animationControllers![widget.selected].forward();
    });
  }

  @override
  void didUpdateWidget(DotsIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selected != oldWidget.selected) {
      _animationControllers![oldWidget.selected].reverse();
      _animationControllers![widget.selected].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers!) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSize = widget.size ?? context.theme.dotsIndicatorTheme().configuration.size;
    final effectiveGap = widget.gap ?? context.theme.dotsIndicatorTheme().configuration.gap;
    final effectiveSelectedColor = widget.selectedColor ?? context.theme.dotsIndicatorTheme().style.selectedColor;
    final effectiveUnselectedColor = widget.unselectedColor ?? context.theme.dotsIndicatorTheme().style.unselectedColor;
    final effectiveTransitionDuration = widget.transitionDuration ?? context.theme.dotsIndicatorTheme().style.transitionDuration;
    final effectiveTransitionCurve = widget.transitionCurve ?? context.theme.dotsIndicatorTheme().style.transitionCurve;

    _animationControllers ??= List.generate(
      widget.count,
      (index) => AnimationController(
        duration: effectiveTransitionDuration,
        vsync: this,
      ),
    );

    _animations ??= List.generate(
      widget.count,
      (index) => _animationControllers![index].drive(_dotColorTween.chain(CurveTween(curve: effectiveTransitionCurve))),
    );

    _dotColorTween
      ..begin = effectiveUnselectedColor
      ..end = effectiveSelectedColor;

    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          widget.count,
          (index) => AnimatedBuilder(
            animation: _animations![index],
            builder: (context, _) => Container(
              width: effectiveSize,
              height: effectiveSize,
              margin: EdgeInsets.symmetric(horizontal: effectiveGap / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _animations![index].value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
